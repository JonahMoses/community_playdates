# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
UserClient::Application.config.secret_key_base = '0cf9520e7195d24cb1b21e0bfadeaa76860361031531eaceded86bc7a311fdc15e4c6a219f381d994e4a6d046805d0f34a819e23b3e1e5bde40c64ad107395a5'
