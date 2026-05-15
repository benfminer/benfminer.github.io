// sharp removed — no prebuilt binary available for this platform
import { QuartzEmitterPlugin } from "../types"

export const Favicon: QuartzEmitterPlugin = () => ({
  name: "Favicon",
  async *emit() {
    // no-op: favicon generation disabled (sharp not available)
  },
  async *partialEmit() {},
})
