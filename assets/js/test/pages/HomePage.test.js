import React from "react"
import { render } from '@testing-library/react'
import '@testing-library/jest-dom/extend-expect'
import HomePage from "../../main/pages/HomePage";

test('Renders welcome message', () => {
  const {getByText} = render(<HomePage />)
  expect(getByText("Welcome to Lutis!")).toBeInTheDocument()
});