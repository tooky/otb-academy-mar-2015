RSpec.describe "a string in Ruby" do
  it "can be created with double quotes" do
    string = "Hello, world!"
    expect( string.is_a?(String) ).to eq true
  end

  it "can be created with single quotes" do
    string = 'Hello, you!'
    expect( string.is_a?(String) ).to eq true
  end

  it "can create a string with double quotes using single quotes" do
    string = '"What a curious feeling!" said Alice.'
    expect( string ).to eq( '"What a curious feeling!" said Alice.' )
  end

  it "can create a string with single quotes using double quotes" do
    string = "Isn't that useful?"
    expect( string ).to eq( "Isn't that useful?" )
  end

  it "can use backslashes to escape the cases that don't fit" do
    double = "Jane said \"Don't\""
    single = 'Jane said "Don\'t"'

    expect( double == single ).to eq( true )
  end

  it "has flexible quoting when things get difficult" do
    a = %(flexible quotes allow both " and ' characters)
    b = %!flexible quotes allow both " and ' characters!
    c = %{flexible quotes allow both " and ' characters}
    d = %#flexible quotes allow both " and ' characters#

    expect( a == b ).to eq( true )
    expect( a == c ).to eq( true )
    expect( a == d ).to eq( true )
  end

  it "can handle multiple lines with flexible quoting" do
    string = %{
Humpty dumpty sat on the wall,
Humpty dumpty had a great fall
}

    expect( string.length ).to eq( 63 )
    expect( string.lines.count ).to eq( 3 )
    expect( string[0,1] ).to eq( "\n" )
  end

  it "can also handle multiple lines with a heredoc" do
    string = <<END
Humpty dumpty sat on the wall,
Humpty dumpty had a great fall
END

    expect( string.length ).to eq( 62 )
    expect( string.lines.count ).to eq( 2 )
    expect( string[0,1] ).to eq( "H" )
  end

  it "can be concatenated with the +" do
    string = "Hello, " + "World!"
    expect( string ).to eq( "Hello, World!" )
  end

  it "will not modify the original string using +" do
    greeting = "Hello, "
    subject  = "World!"
    string = greeting + subject

    expect( string ).to eq( "Hello, World!" )
    expect( greeting ).to eq( "Hello, " )
    expect( subject ).to eq( "World!" )
  end

  it "will concatenate on the end of a string using +=" do
    original_greeting = "Hello, "
    puts
    puts "original_greeting: "  + original_greeting.object_id.to_s
    greeting = original_greeting
    subject  = "World!"
    puts "greeting: " + greeting.object_id.to_s
    greeting += subject
    puts "greeting += subject: " + greeting.object_id.to_s

    expect( original_greeting ).to eq( "Hello, " )
  end

  it "will also add to the end of the string using the shovel operator" do
    original_greeting = "Hello, "
    puts "original_greeting: "  + original_greeting.object_id.to_s
    greeting = original_greeting
    subject  = "World!"
    puts "greeting: " + greeting.object_id.to_s
    greeting << subject
    puts "greeting << subject: " + greeting.object_id.to_s

    expect( original_greeting ).to eq( "Hello, World!" )
  end

  it "will interpret escape characters with double quotes" do
    string = "\n"
    expect( string.size ).to eq( 1 )
  end

  it "won't interpret escape characters with single quotes" do
    string = '\n'
    expect( string.size ).to eq( 2 )
  end

  it "does interpret some escape characters with single quotes though" do
    string = '\\\\'
    expect( string.size ).to eq( 2 )
  end

  it "can interpolate variable using double quotes" do
    count = 99
    string = "#{count} bottles of beer on the wall."

    expect( string ).to eq( '99 bottles of beer on the wall.' )
  end

  it "won't interpolate variable using single quotes" do
    count = 99
    string = '#{count} bottles of beer on the wall.'

    expect( string ).to eq( '#{count} bottles of beer on the wall.' )
  end

  it "will interporlate any ruby expression" do
    count = 99
    string = "#{(count - 1) / 2} bottles of beer on the wall."

    expect( string ).to eq( "49 bottles of beer on the wall." )
  end

  it "can extract a substring" do
    string = "Bacon, lettuce and tomato"

    expect( string[7,3] ).to eq( "let" )
    expect( string[7..9] ).to eq( "let" )
  end

  it "can extract a single character" do
    string = "Bacon, lettuce and tomato"
    expect( string[1] ).to eq( "a" )
  end

  it "represents single characters as strings" do
    expect( ?a ).to eq( "a" )
    expect( ?a == 97 ).to eq( false )
  end

  it "can split a string" do
    string = "Strings Are Fun"
    words = string.split

    expect( words ).to eq( ["Strings", "Are", "Fun"] )
  end

  it "can split a string on other characters" do
    string = "has:many:through"
    words = string.split(":")

    expect( words ).to eq( ["has", "many", "through"] )
  end

  it "can join strings" do
    words = ["Welcome", "to", "the", "joinery"]
    string = words.join(" ")

    expect( string ).to eq( "Welcome to the joinery" )
  end

  it "is a unique object" do
    a = "Hello, world!"
    b = "Hello, world!"

    expect( a == b ).to eq( true )
    expect( a.object_id == b.object_id ).to eq( false )
  end

  it "can increment last character of string" do
    string = "this is a string"
    expect( string.succ ).to eq( "this is a strinh" )
  end

  it "carries the increment" do
    string = "ZZZZ9999"
    expect( string.succ ).to eq( "AAAAA0000" )
  end

  it "replaces portion of string and retains original object" do
    string = "hippo"
    new_string = string.tr("ip", "*")
    expect( new_string ).to eq( "h***o" )
    expect( string ).to eq( "hippo" )
  end

  it "removes contiguous characters from a string" do
    string = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaarghhhhh"
    new_string = string.squeeze
    expect( new_string ).to eq("argh")
    expect( string ).to eq("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaarghhhhh")
  end

  it "removes contiguous spaces from a string only" do
    string = "too                 maaaaany            spaaaaces"
    new_string = string.squeeze(" ")
    expect( new_string ).to eq("too maaaaany spaaaaces")
  end

  it "partitions string based on numbers" do
    string = "27bslash4"
    new_string = string.partition("bslash")
    expect( new_string ).to eq(["27","bslash","4"])
    puts new_string.to_s
  end
end
