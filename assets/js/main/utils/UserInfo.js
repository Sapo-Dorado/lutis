var UserInfo = (() => {
  let email = null
  let token = null

  let getEmail = () => {
    return email
  }

  let setEmail = new_email => {
    email = new_email
  }

  let getToken = () => {
    return token
  }

  let setToken = new_token => {
    token = new_token
  }

  return {
    getEmail: getEmail,
    setEmail: setEmail,
    getToken: getToken,
    setToken: setToken
  }
})()

export default UserInfo