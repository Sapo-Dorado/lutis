import { setUsername } from "../../main/utils/Util"

const exampleUsername = "exampleUsername"
const jsonObject = {
  data: {
    username: exampleUsername
  }
}

test("setUsername returns the result of fetch", async () => {
  global.fetch = jest.fn((url, headers) => 
    Promise.resolve({
      json: () => Promise.resolve(jsonObject)
    })
  )
  expect(await setUsername("email", "token","username")).toStrictEqual(jsonObject)
})