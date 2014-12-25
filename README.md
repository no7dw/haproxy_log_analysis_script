log analysis script for haproxy


[ log time ]            [ haproxy pid ]   [ user ip ]       [ request time ]             [ frontend ]
Jul 16 11:28:48 localhost haproxy[61454]: 119.39.3.85:18658 [16/Jul/2014:11:28:48.224] node_server_in

[ backend/server ]                    [ timer (ms) ]    [status code]  [ response length]         [state]
 weather_app_servers/tiger_node_6300  1/0/0/227/281        200                       4896             - -       ----  

[ connections ]  [ queue ]                                         [ method url ]
     8/8/1/0/0            0/0          "GET /app/index?did=61832cf4bbf8ebb2&nt=wifi HTTP/1.1"


Timer  Tq / Tw / Tc / Tr / Tt       ----    1/0/0/227/281   5776/0/0/28/6477
	"Tq" is the total time in milliseconds spent waiting for the client to send a full HTTP request, not counting data.  Large times here generally indicate network trouble between the client and haproxy.
	"Tw" is the total time in milliseconds spent waiting in the various queues.
	"Tc" is the total time in milliseconds spent waiting for the connection to establish to the final server, including retries.
	"Tr" is the total time in milliseconds spent waiting for the server to send a full HTTP response, not counting data.
"Tt" is the total time in milliseconds elapsed between the accept and the last close.


Session state  ----   ----   CD--   SH--
	1st character:   the first event which caused the session to terminate
	C : the TCP session was unexpectedly aborted by the client.
	S : the TCP session was unexpectedly aborted by the server, or the server explicitly refused it.
	c : the client-side timeout expired while waiting for the client to send or receive data.
	s : the server-side timeout expired while waiting for the server to send or receive data.
	- : normal session completion, both the client and the server closed with nothing left in the buffers.
	2nd character:   the TCP or HTTP session state when it was closed
	D : the session was in the DATA phase.
	- : normal session completion after end of data transfer.

