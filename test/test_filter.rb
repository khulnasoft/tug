# frozen_string_literal: true

require_relative 'lib/common'

# Non-interactive tests
class TestFilter < TestBase
  def test_default_extended
    assert_equal '100', `seq 100 | #{TUG} -f "1 00$"`.chomp
    assert_equal '', `seq 100 | #{TUG} -f "1 00$" +x`.chomp
  end

  def test_exact
    assert_equal 4, `seq 123 | #{TUG} -f 13`.lines.length
    assert_equal 2, `seq 123 | #{TUG} -f 13 -e`.lines.length
    assert_equal 4, `seq 123 | #{TUG} -f 13 +e`.lines.length
  end

  def test_or_operator
    assert_equal %w[1 5 10], `seq 10 | #{TUG} -f "1 | 5"`.lines(chomp: true)
    assert_equal %w[1 10 2 3 4 5 6 7 8 9],
                 `seq 10 | #{TUG} -f '1 | !1'`.lines(chomp: true)
  end

  def test_smart_case_for_each_term
    assert_equal 1, `echo Foo bar | #{TUG} -x -f "foo Fbar" | wc -l`.to_i
  end

  def test_filter_exitstatus
    # filter / streaming filter
    ['', '--no-sort'].each do |opts|
      assert_includes `echo foo | #{TUG} -f foo #{opts}`, 'foo'
      assert_equal 0, $CHILD_STATUS.exitstatus

      assert_empty `echo foo | #{TUG} -f bar #{opts}`
      assert_equal 1, $CHILD_STATUS.exitstatus
    end
  end

  def test_long_line
    data = '.' * 256 * 1024
    File.open(tempname, 'w') do |f|
      f << data
    end
    assert_equal data, `#{TUG} -f . < #{tempname}`.chomp
  end

  def test_read0
    lines = `find .`.lines(chomp: true)
    assert_equal lines.last, `find . | #{TUG} -e -f "^#{lines.last}$"`.chomp
    assert_equal \
      lines.last,
      `find . -print0 | #{TUG} --read0 -e -f "^#{lines.last}$"`.chomp
  end

  def test_nth_suffix_match
    assert_equal \
      'foo,bar,baz',
      `echo foo,bar,baz | #{TUG} -d, -f'bar$' -n2`.chomp
  end

  def test_with_nth_basic
    writelines(['hello world ', 'byebye'])
    assert_equal \
      'hello world ',
      `#{TUG} -f"^he hehe" -x -n 2.. --with-nth 2,1,1 < #{tempname}`.chomp
  end

  def test_with_nth_template
    writelines(['hello world ', 'byebye'])
    assert_equal \
      'hello world ',
      `#{TUG} -f"^he he.he." -x -n 2.. --with-nth '{2} {1}. {1}.' < #{tempname}`.chomp
  end

  def test_with_nth_ansi
    writelines(["\x1b[33mhello \x1b[34;1mworld\x1b[m ", 'byebye'])
    assert_equal \
      'hello world ',
      `#{TUG} -f"^he hehe" -x -n 2.. --with-nth 2,1,1 --ansi < #{tempname}`.chomp
  end

  def test_with_nth_no_ansi
    src = "\x1b[33mhello \x1b[34;1mworld\x1b[m "
    writelines([src, 'byebye'])
    assert_equal \
      src,
      `#{TUG} -fhehe -x -n 2.. --with-nth 2,1,1 --no-ansi < #{tempname}`.chomp
  end

  def test_escaped_meta_characters
    input = [
      'foo^bar',
      'foo$bar',
      'foo!bar',
      "foo'bar",
      'foo bar',
      'bar foo'
    ]
    writelines(input)

    assert_equal input.length, `#{TUG} -f'foo bar' < #{tempname}`.lines.length
    assert_equal input.length - 1, `#{TUG} -f'^foo bar$' < #{tempname}`.lines.length
    assert_equal ['foo bar'], `#{TUG} -f'foo\\ bar' < #{tempname}`.lines(chomp: true)
    assert_equal ['foo bar'], `#{TUG} -f'^foo\\ bar$' < #{tempname}`.lines(chomp: true)
    assert_equal input.length - 1, `#{TUG} -f'!^foo\\ bar$' < #{tempname}`.lines.length
  end

  def test_normalized_match
    echoes = '(echo a; echo á; echo A; echo Á;)'
    assert_equal %w[a á A Á], `#{echoes} | #{TUG} -f a`.lines.map(&:chomp)
    assert_equal %w[á Á], `#{echoes} | #{TUG} -f á`.lines.map(&:chomp)
    assert_equal %w[A Á], `#{echoes} | #{TUG} -f A`.lines.map(&:chomp)
    assert_equal %w[Á], `#{echoes} | #{TUG} -f Á`.lines.map(&:chomp)
  end

  def test_unicode_case
    writelines(%w[строКА1 СТРОКА2 строка3 Строка4])
    assert_equal %w[СТРОКА2 Строка4], `#{TUG} -fС < #{tempname}`.lines(chomp: true)
    assert_equal %w[строКА1 СТРОКА2 строка3 Строка4], `#{TUG} -fс < #{tempname}`.lines(chomp: true)
  end

  def test_tiebreak
    input = %w[
      --foobar--------
      -----foobar---
      ----foobar--
      -------foobar-
    ]
    writelines(input)

    assert_equal input, `#{TUG} -ffoobar --tiebreak=index < #{tempname}`.lines(chomp: true)

    by_length = %w[
      ----foobar--
      -----foobar---
      -------foobar-
      --foobar--------
    ]
    assert_equal by_length, `#{TUG} -ffoobar < #{tempname}`.lines(chomp: true)
    assert_equal by_length, `#{TUG} -ffoobar --tiebreak=length < #{tempname}`.lines(chomp: true)

    by_begin = %w[
      --foobar--------
      ----foobar--
      -----foobar---
      -------foobar-
    ]
    assert_equal by_begin, `#{TUG} -ffoobar --tiebreak=begin < #{tempname}`.lines(chomp: true)
    assert_equal by_begin, `#{TUG} -f"!z foobar" -x --tiebreak begin < #{tempname}`.lines(chomp: true)

    assert_equal %w[
      -------foobar-
      ----foobar--
      -----foobar---
      --foobar--------
    ], `#{TUG} -ffoobar --tiebreak end < #{tempname}`.lines(chomp: true)

    assert_equal input, `#{TUG} -f"!z" -x --tiebreak end < #{tempname}`.lines(chomp: true)
  end

  def test_tiebreak_index_begin
    writelines([
                 'xoxxxxxoxx',
                 'xoxxxxxox',
                 'xxoxxxoxx',
                 'xxxoxoxxx',
                 'xxxxoxox',
                 '  xxoxoxxx'
               ])

    assert_equal [
      'xxxxoxox',
      '  xxoxoxxx',
      'xxxoxoxxx',
      'xxoxxxoxx',
      'xoxxxxxox',
      'xoxxxxxoxx'
    ], `#{TUG} -foo < #{tempname}`.lines(chomp: true)

    assert_equal [
      'xxxoxoxxx',
      'xxxxoxox',
      '  xxoxoxxx',
      'xxoxxxoxx',
      'xoxxxxxoxx',
      'xoxxxxxox'
    ], `#{TUG} -foo --tiebreak=index < #{tempname}`.lines(chomp: true)

    # Note that --tiebreak=begin is now based on the first occurrence of the
    # first character on the pattern
    assert_equal [
      '  xxoxoxxx',
      'xxxoxoxxx',
      'xxxxoxox',
      'xxoxxxoxx',
      'xoxxxxxoxx',
      'xoxxxxxox'
    ], `#{TUG} -foo --tiebreak=begin < #{tempname}`.lines(chomp: true)

    assert_equal [
      '  xxoxoxxx',
      'xxxoxoxxx',
      'xxxxoxox',
      'xxoxxxoxx',
      'xoxxxxxox',
      'xoxxxxxoxx'
    ], `#{TUG} -foo --tiebreak=begin,length < #{tempname}`.lines(chomp: true)
  end

  def test_tiebreak_begin_algo_v2
    writelines(['baz foo bar',
                'foo bar baz'])
    assert_equal [
      'foo bar baz',
      'baz foo bar'
    ], `#{TUG} -fbar --tiebreak=begin --algo=v2 < #{tempname}`.lines(chomp: true)
  end

  def test_tiebreak_end
    writelines(['xoxxxxxxxx',
                'xxoxxxxxxx',
                'xxxoxxxxxx',
                'xxxxoxxxx',
                'xxxxxoxxx',
                '  xxxxoxxx'])

    assert_equal [
      '  xxxxoxxx',
      'xxxxoxxxx',
      'xxxxxoxxx',
      'xoxxxxxxxx',
      'xxoxxxxxxx',
      'xxxoxxxxxx'
    ], `#{TUG} -fo < #{tempname}`.lines(chomp: true)

    assert_equal [
      'xxxxxoxxx',
      '  xxxxoxxx',
      'xxxxoxxxx',
      'xxxoxxxxxx',
      'xxoxxxxxxx',
      'xoxxxxxxxx'
    ], `#{TUG} -fo --tiebreak=end < #{tempname}`.lines(chomp: true)

    assert_equal [
      'xxxxxoxxx',
      '  xxxxoxxx',
      'xxxxoxxxx',
      'xxxoxxxxxx',
      'xxoxxxxxxx',
      'xoxxxxxxxx'
    ], `#{TUG} -fo --tiebreak=end,length,begin < #{tempname}`.lines(chomp: true)

    writelines(['/bar/baz', '/foo/bar/baz'])
    assert_equal [
      '/foo/bar/baz',
      '/bar/baz'
    ], `#{TUG} -fbaz --tiebreak=end < #{tempname}`.lines(chomp: true)
  end

  def test_tiebreak_length_with_nth
    input = %w[
      1:hell
      123:hello
      12345:he
      1234567:h
    ]
    writelines(input)

    output = %w[
      1:hell
      12345:he
      123:hello
      1234567:h
    ]
    assert_equal output, `#{TUG} -fh < #{tempname}`.lines(chomp: true)

    # Since 0.16.8, --nth doesn't affect --tiebreak
    assert_equal output, `#{TUG} -fh -n2 -d: < #{tempname}`.lines(chomp: true)
  end

  def test_tiebreak_chunk
    writelines(['1 foobarbaz ba',
                '2 foobar baz',
                '3 foo barbaz'])

    assert_equal [
      '3 foo barbaz',
      '2 foobar baz',
      '1 foobarbaz ba'
    ], `#{TUG} -fo --tiebreak=chunk < #{tempname}`.lines(chomp: true)

    assert_equal [
      '1 foobarbaz ba',
      '2 foobar baz',
      '3 foo barbaz'
    ], `#{TUG} -fba --tiebreak=chunk < #{tempname}`.lines(chomp: true)

    assert_equal [
      '3 foo barbaz'
    ], `#{TUG} -f'!foobar' --tiebreak=chunk < #{tempname}`.lines(chomp: true)
  end

  def test_boundary_match
    # Underscore boundaries should be ranked lower
    {
      default: [' x '] + %w[/x/ [x] -x- -x_ _x- _x_],
      path: ['/x/', ' x '] + %w[[x] -x- -x_ _x- _x_],
      history: ['[x]', '-x-', ' x '] + %w[/x/ -x_ _x- _x_]
    }.each do |scheme, expected|
      result = `printf -- 'xxx\n-xx\nxx-\n_x_\n_x-\n-x_\n[x]\n-x-\n x \n/x/\n' | #{TUG} -f"'x'" --scheme=#{scheme}`.lines(chomp: true)
      assert_equal expected, result
    end
  end
end
