-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2015-2017, Lars Asplund lars.anders.asplund@gmail.com

use work.com_types_pkg.all;
use work.com_pkg.all;

package com_string_payload_pkg is
  procedure send (
    signal net        : inout network_t;
    constant sender   : in    actor_t;
    constant receiver : in    actor_t;
    constant payload  : in    string := "";
    variable receipt  : out   receipt_t;
    constant timeout  : in    time   := max_timeout_c);
  procedure send (
    signal net        : inout network_t;
    constant sender   : in    actor_t;
    constant receiver : in    actor_t;
    constant payload  : in    string := "";
    constant timeout  : in    time   := max_timeout_c);
  procedure send (
    signal net        : inout network_t;
    constant receiver : in    actor_t;
    constant payload  : in    string := "";
    variable receipt  : out   receipt_t;
    constant timeout  : in    time   := max_timeout_c);
  procedure send (
    signal net        : inout network_t;
    constant receiver : in    actor_t;
    constant payload  : in    string := "";
    constant timeout  : in    time   := max_timeout_c);
  procedure request (
    signal net               : inout network_t;
    constant sender          : in    actor_t;
    constant receiver        : in    actor_t;
    constant request_payload : in    string := "";
    variable reply_message   : inout message_ptr_t;
    constant timeout         : in    time   := max_timeout_c);
  procedure request (
    signal net               : inout network_t;
    constant sender          : in    actor_t;
    constant receiver        : in    actor_t;
    constant request_payload : in    string := "";
    variable positive_ack    : out   boolean;
    constant timeout         : in    time   := max_timeout_c);
  procedure reply (
    signal net          : inout network_t;
    variable request   : inout    message_ptr_t;
    constant payload    : in    string := "";
    constant timeout    : in    time   := max_timeout_c);
  procedure publish (
    signal net       : inout network_t;
    constant sender  : in    actor_t;
    constant payload : in    string := "";
    constant timeout : in    time   := max_timeout_c);
end package com_string_payload_pkg;

package body com_string_payload_pkg is
  procedure send (
    signal net        : inout network_t;
    constant sender   : in    actor_t;
    constant receiver : in    actor_t;
    constant payload  : in    string := "";
    variable receipt  : out   receipt_t;
    constant timeout  : in    time   := max_timeout_c) is
    variable message : message_ptr_t;
  begin
    message := compose(payload, sender);
    send(net, receiver, message, timeout, keep_message => true);
    receipt := (status => ok, id => message.id);
    delete(message);
  end;

  procedure send (
    signal net        : inout network_t;
    constant sender   : in    actor_t;
    constant receiver : in    actor_t;
    constant payload  : in    string := "";
    constant timeout  : in    time   := max_timeout_c) is
    variable message : message_ptr_t;
  begin
    message := compose(payload, sender);
    send(net, receiver, message, timeout, keep_message => false);
  end;

  procedure send (
    signal net        : inout network_t;
    constant receiver : in    actor_t;
    constant payload  : in    string := "";
    variable receipt  : out   receipt_t;
    constant timeout  : in    time   := max_timeout_c) is
    variable message : message_ptr_t;
  begin
    message := compose(payload);
    send(net, receiver, message, timeout, keep_message => true);
    receipt := (status => ok, id => message.id);
    delete(message);
  end;

  procedure send (
    signal net        : inout network_t;
    constant receiver : in    actor_t;
    constant payload  : in    string := "";
    constant timeout  : in    time   := max_timeout_c) is
    variable message : message_ptr_t;
  begin
    message := compose(payload);
    send(net, receiver, message, timeout, keep_message => false);
  end;

  procedure request (
    signal net               : inout network_t;
    constant sender          : in    actor_t;
    constant receiver        : in    actor_t;
    constant request_payload : in    string := "";
    variable reply_message   : inout message_ptr_t;
    constant timeout         : in    time   := max_timeout_c) is
    variable request_message : message_ptr_t;
  begin
    request_message := compose(request_payload, sender);
    request(net, receiver, request_message, reply_message, timeout);
  end;

  procedure request (
    signal net               : inout network_t;
    constant sender          : in    actor_t;
    constant receiver        : in    actor_t;
    constant request_payload : in    string := "";
    variable positive_ack    : out   boolean;
    constant timeout         : in    time   := max_timeout_c) is
    variable request_message : message_ptr_t;
  begin
    request_message := compose(request_payload, sender);
    request(net, receiver, request_message, positive_ack, timeout);
  end;

  procedure reply (
    signal net          : inout network_t;
    variable request   : inout    message_ptr_t;
    constant payload    : in    string := "";
    constant timeout    : in    time   := max_timeout_c) is
    variable message : message_ptr_t;
  begin
    message := compose(payload);
    reply(net, request, message, timeout);
  end;

  procedure publish (
    signal net       : inout network_t;
    constant sender  : in    actor_t;
    constant payload : in    string := "";
    constant timeout : in    time   := max_timeout_c) is
    variable message : message_ptr_t;
  begin
    message := compose(payload, sender);
    publish(net, message, timeout);
  end;
end package body com_string_payload_pkg;
