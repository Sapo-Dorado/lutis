import React from "react"
import { render } from '@testing-library/react'
import '@testing-library/jest-dom/extend-expect'
import LoginButton from "../../main/components/LoginButton"

test('renders the link', () => {
  const { getByText } = render(<LoginButton />)
  expect(getByText("Sign in")).toBeInTheDocument()
})