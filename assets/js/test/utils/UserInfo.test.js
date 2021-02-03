import UserInfo from "../../main/utils/UserInfo";

const exampleEmail = "test@email.com"
const exampleUsername = "exampleUsername"
const exampleToken = "exampleToken"

test("get and set email", () => {
  UserInfo.setEmail(exampleEmail)
  expect(UserInfo.getEmail()).toBe(exampleEmail)
})

test("get and set username", () => {
  UserInfo.setUsername(exampleUsername)
  expect(UserInfo.getUsername()).toBe(exampleUsername)
})

test("get and set token", () => {
  UserInfo.setToken(exampleToken)
  expect(UserInfo.getToken()).toBe(exampleToken)
})