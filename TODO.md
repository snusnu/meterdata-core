* It should store temporary data only in "#{Dir.pwd}/.meterdata"
* It should be possible to configure specific meterdata runs
    * It should be possible to specify the configuration programmatically
    * It should be possible to load the configuration from a JSON or YAML file
    * It should be possible to load the configuration from a remote JSON service
* It should track file changes
    * It should only run generators on files that actually changed when that makes sense
* Every generator should be able to work independently
    * It should accept all options necessary to produce the output
        * It should accept options passed directly as a Hash
        * It should be able to load options from a per project config file
        * it should be able to load options from a configured remote source
    * It should define an interface how native metric generatros will be invoked
        * It should define a method that runs the native metric generator
        * It should define a method that turns the raw output into a processable hash
        * It should publish the metric results once they have been processed
    * It should be possible to subscribe to available metric generator results
        * It should be possible to store the metric data on disk
        * It should be possible to post the metric data to a preconfigured service
* It should be possible to run a configured set of metric data generators
    * It should be possible to run multiple metric data generators in parallel
    * It should publish metric data from any generator as soon as it finishes