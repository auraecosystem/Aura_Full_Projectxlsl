// errors.ts

const DEV = import.meta.env?.DEV ?? process.env.NODE_ENV !== "production"

type ErrorFactory = (...args: any[]) => string

const errorMap = {
  E1000: "Unknown application error",

  E1001(field: string) {
    return `Missing required field '${field}'`
  },

  E1002(route: string) {
    return `Route '${route}' was not found`
  },

  E1003(expected: string, received: string) {
    return `Expected '${expected}' but received '${received}'`
  },

  E1004(action: string) {
    return `Unauthorized to perform '${action}'`
  }
} as const satisfies Record<string, string | ErrorFactory>

type ErrorCode = keyof typeof errorMap

function resolveMessage(
  code: ErrorCode,
  args: unknown[]
): string {
  const entry = errorMap[code]

  if (typeof entry === "function") {
    return entry(...args)
  }

  return entry
}

export class AppError extends Error {
  readonly code: ErrorCode

  constructor(code: ErrorCode, ...args: unknown[]) {
    const message = DEV
      ? resolveMessage(code, args)
      : `[${code}] https://aura.dev/errors/${code}`

    super(message)

    this.name = "AppError"
    this.code = code
  }
}

/**
 * Always throws
 */
export function panic(
  code: ErrorCode,
  ...args: unknown[]
): never {
  throw new AppError(code, ...args)
}

/**
 * Assertion helper
 */
export function invariant(
  condition: unknown,
  code: ErrorCode,
  ...args: unknown[]
): asserts condition {
  if (!condition) {
    throw new AppError(code, ...args)
  }
}

/**
 * Convenience helper
 */
export function unreachable(
  value: never
): never {
  panic("E1000", value)
}
