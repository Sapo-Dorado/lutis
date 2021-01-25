import Root from "../Root"
import React from "react"
import { render } from '@testing-library/react'
import '@testing-library/jest-dom/extend-expect'

test('Renders welcome message', () => {
  const {getByText} = render(<Root />)
  expect(getByText("Welcome to Lutis!")).toBeInTheDocument()
});