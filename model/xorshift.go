// Marsaglia xorshift PRNG in Go.

package main
import "fmt"

type prng_state struct {
	state uint32
}


func InitState(seed uint32) *prng_state {
	my_state := prng_state{state: seed}
	return &my_state
}


func UpdateState(state *prng_state) {
	state.state ^= state.state << 13
	state.state ^= state.state >> 17
	state.state ^= state.state << 5
}


func GetState(state *prng_state) uint32 {
	return state.state
}

func RolWord32(w uint32, b uint32) uint32 {
	return (w << b)
}

func RorWord32(w uint32, b uint32) uint32 {
	return (w >> b)
}

func main() {
	fmt.Println("Creating a PRNG state.")

	var prng_value uint32
	my_prng_state := InitState(0xdeadbeef)

	fmt.Println("Generating a number of state words:")
	for i := 0 ; i < 1 ; i++ {
		UpdateState(my_prng_state)
		prng_value = GetState(my_prng_state)
		fmt.Printf("prng_value %d: 0x%08x\n", i, prng_value)
	}
	fmt.Printf("0xdeadbeef << 1:  0x%08x\n", (RolWord32(0xdeadbeef, 1)))
	fmt.Printf("0xdeadbeef << 2:  0x%08x\n", (RolWord32(0xdeadbeef, 2)))
	fmt.Printf("0xdeadbeef << 7:  0x%08x\n", (RolWord32(0xdeadbeef, 7)))
	fmt.Printf("0xdeadbeef << 8:  0x%08x\n", (RolWord32(0xdeadbeef, 8)))
	fmt.Printf("0xdeadbeef << 13: 0x%08x\n", (RolWord32(0xdeadbeef, 13)))
	fmt.Printf("0xdeadbeef << 15: 0x%08x\n", (RolWord32(0xdeadbeef, 15)))
	fmt.Printf("0xdeadbeef << 16: 0x%08x\n", (RolWord32(0xdeadbeef, 16)))

	fmt.Printf("\n")

	fmt.Printf("0xdeadbeef >> 1:  0x%08x\n", (RorWord32(0xdeadbeef, 1)))
	fmt.Printf("0xdeadbeef >> 2:  0x%08x\n", (RorWord32(0xdeadbeef, 2)))
	fmt.Printf("0xdeadbeef >> 7:  0x%08x\n", (RorWord32(0xdeadbeef, 7)))
	fmt.Printf("0xdeadbeef >> 8:  0x%08x\n", (RorWord32(0xdeadbeef, 8)))
	fmt.Printf("0xdeadbeef >> 13: 0x%08x\n", (RorWord32(0xdeadbeef, 13)))
	fmt.Printf("0xdeadbeef >> 15: 0x%08x\n", (RorWord32(0xdeadbeef, 15)))
	fmt.Printf("0xdeadbeef >> 16: 0x%08x\n", (RorWord32(0xdeadbeef, 16)))
}
