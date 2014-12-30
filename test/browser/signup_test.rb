# encoding: utf-8
require 'browser_test_helper'

class SignupTest < TestCase
  def test_signup
    signup_user_email = 'signup-test-' + rand(999999).to_s + '@example.com'
    tests = [
      {
        :name     => 'start',
        :instance => browser_instance,
        :url      => browser_url,
        :action   => [
          {
            :execute => 'click',
            :css     => 'a[href="#signup"]',
          },
          {
            :execute => 'check',
            :css     => '.signup',
            :result  => true,
          },
        ],
      },
      {
        :name     => 'signup',
        :action   => [
          {
            :execute => 'set',
            :css     => 'input[name="firstname"]',
            :value   => 'Signup Firstname',
          },
          {
            :execute => 'set',
            :css     => 'input[name="lastname"]',
            :value   => 'Signup Lastname',
          },
          {
            :execute => 'set',
            :css     => 'input[name="email"]',
            :value   => signup_user_email,
          },
          {
            :execute => 'set',
            :css     => 'input[name="password"]',
            :value   => 'some-pass',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_confirm"]',
            :value   => 'some-pass',
          },
          {
            :execute => 'click',
            :css     => 'button.submit',
          },
          {
            :execute => 'wait',
            :value   => 5,
          },
          {
            :execute => 'check',
            :css     => '.signup',
            :result  => false,
          },
          {
            :execute      => 'match',
            :css          => '.user-menu .user a',
            :attribute    => 'title',
            :value        => signup_user_email,
            :match_result => true,
          },
        ],
      },
      {
        :name     => 'set password',
        :action   => [
          {
            :execute => 'click',
            :css     => '.navbar-items-personal .user a',
          },
          {
            :execute => 'wait',
            :value   => 1,
          },
          {
            :execute => 'click',
            :css     => 'a[href="#profile"]',
          },
          {
            :execute => 'click',
            :css     => 'a[href="#profile/password"]',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_old"]',
            :value   => 'nonexisiting',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new"]',
            :value   => 'some',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new_confirm"]',
            :value   => 'some',
          },
          {
            :execute => 'click',
            :css     => '.content .btn--primary',
          },
          {
            :execute => 'watch_for',
            :area    => 'body',
            :value   => 'old password is wrong',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_old"]',
            :value   => 'some-pass',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new_confirm"]',
            :value   => 'some2',
          },
          {
            :execute => 'click',
            :css     => '.content .btn--primary',
          },
          {
            :execute => 'watch_for',
            :area    => 'body',
            :value   => 'passwords do not match',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new"]',
            :value   => 'some',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new_confirm"]',
            :value   => 'some',
          },
          {
            :execute => 'click',
            :css     => '.content .btn--primary',
          },
          {
            :execute => 'watch_for',
            :area    => 'body',
            :value   => 'it must be at least',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new"]',
            :value   => 'some-pass-new',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new_confirm"]',
            :value   => 'some-pass-new',
          },
          {
            :execute => 'click',
            :css     => '.content .btn--primary',
          },
          {
            :execute => 'watch_for',
            :area    => 'body',
            :value   => 'must contain at least 1 digit',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new"]',
            :value   => 'some-pass-new2',
          },
          {
            :execute => 'set',
            :css     => 'input[name="password_new_confirm"]',
            :value   => 'some-pass-new2',
          },
          {
            :execute => 'click',
            :css     => '.content .btn--primary',
          },
          {
            :execute => 'watch_for',
            :area    => 'body',
            :value   => 'Password changed successfully',
          },
          {
            :execute  => 'logout',
          },
          {
            :execute  => 'login',
            :username => signup_user_email,
            :password => 'some-pass-new2',
          },
        ],
      },
    ]
    browser_single_test(tests)
  end
end
