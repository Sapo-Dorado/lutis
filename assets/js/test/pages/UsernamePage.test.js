import React from "react"
import { render, fireEvent, screen } from "@testing-library/react"
import "@testing-library/jest-dom/extend-expect"
import UsernamePage from "../../main/pages/UsernamePage"
import UserInfo from "../../main/utils/UserInfo"
import { setUsername } from "../../main/utils/Util"
jest.mock("../../main/utils/Util.js")

const exampleEmail = "test@email.com"
const exampleToken = "exampleToken"
const exampleUsername = "exampleUsername"

beforeAll(() => {
  UserInfo.setEmail(exampleEmail)
  UserInfo.setToken(exampleToken)
  UserInfo.setUsername(null)

  global.window = Object.create(window)
  Object.defineProperty(window, "location", {
    value: {
      href: "url"
    }
  })

  setUsername.mockImplementation((_email, token, username) => {
    if(token !== exampleToken) {
      return Promise.resolve({
        errors: {
          auth: ["unauthorized"]
        }
      })
    } else if(username === exampleUsername) {
      return Promise.resolve({
        data: {
          username: exampleUsername
        }
      })
    } else {
      return Promise.resolve({
        errors: {
          username: ["Can't be blank"]
        }
      })
    }
  })
})

test("updates username with valid inputs", async () => {
  const { getByText } = render(<UsernamePage />)
  expect(getByText("Enter a username:")).toBeInTheDocument()
  fireEvent.change(screen.getByLabelText("Enter a username:"), {target: {value: exampleUsername}})
  await fireEvent.click(screen.getByText("Enter"))
  expect(UserInfo.getUsername()).toBe(exampleUsername)
  expect(window.location.href).toBe(`/?email=${exampleEmail}&token=${exampleToken}&username=${exampleUsername}`)
})

test("shows errors when username is invalid", async () => {
  const { getByText } = render(<UsernamePage />)
  await fireEvent.click(screen.getByText("Enter"))
  expect(getByText("Can't be blank")).toBeInTheDocument()
})

test("redirects to home if token is invalid", async () => {
  UserInfo.setToken("Invalid Token")
  render(<UsernamePage />)
  fireEvent.change(screen.getByLabelText("Enter a username:"), {target: {value: exampleUsername}})
  await fireEvent.click(screen.getByText("Enter"))
  expect(window.location.href).toBe("/")
})