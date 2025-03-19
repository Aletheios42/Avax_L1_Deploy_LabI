package main

import (
	"fmt"
	"os"

	"github.com/ava-labs/avalanchego/utils/logging"
	"github.com/ava-labs/avalanchego/vms/rpcchainvm"
	"github.com/ava-labs/subnet-evm/plugin/evm"
)

func main() {
	// This is just a wrapper around subnet-evm
	plugin, err := evm.New()
	if err != nil {
		fmt.Printf("error creating plugin: %v\n", err)
		os.Exit(1)
	}

	// Create the logger
	logFactory := logging.NewFactory(logging.Config{})
	log, err := logFactory.Make("sauco")
	if err != nil {
		fmt.Printf("error creating logger: %v\n", err)
		os.Exit(1)
	}

	// Start the plugin
	plugin.SetLogger(log)
	rpcchainvm.Serve(plugin)
}

