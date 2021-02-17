var UserInfo = (() => {
  let username = null
  let email = null
  let token = null

  let getEmail = () => {
    return email
  }

  let setEmail = new_email => {
    email = new_email
  }

  let setUsername = new_username => {
    username = new_username
  }

  let getUsername = () => {
    return username
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
    getUsername: getUsername,
    setUsername: setUsername,
    getToken: getToken,
    setToken: setToken
  }
})()

export default UserInfo