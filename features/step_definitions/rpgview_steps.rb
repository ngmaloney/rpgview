When 'I run rpgview without a schema argument' do
  @output = `rpgview`
end

Then 'it displays a schema not specified error message' do
  @output.should =~ /A valid schema file is required./
end

When 'I run rpgview using the example schema' do
  file = File.join(File.dirname(__FILE__),'..','support','sample-schema.yaml')
  @output = `rpgview #{file}`
end

Then 'it should output the correct sql' do
  expected_output = File.read(File.join(File.dirname(__FILE__),'..','support','sample-output.sql'))
  @output.should == expected_output
end