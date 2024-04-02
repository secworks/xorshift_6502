// Marsaglia xorshift PRNG in Go.

package main
import "fmt"

type prng_state struct {
	state uint32
}


func InitPrng(seed uint32) *prng_state {
	var my_state prng_state
	my_state.state = seed
	return &my_state
}


func UpdateState(prng_state *state) (uint32, *prng_state) {
	return prng_state.state, *state
}


func main() {
	fmt.Println("Creating a PRNG state.")

	var uint32 prng_value = 0
	my_prng_state := InitPrng(0xdeadbeef)

	fmt.Println("Generating a number of state words:")
	for i := 0 ; i < 64 ; i++ {
		prng_value, my_prng_state = UpdateState(my_prng_state)
		fmt.Printf("prng_value %d: %d\n", i, prng_value)
	}
}
