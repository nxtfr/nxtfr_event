%%%-------------------------------------------------------------------
%% @doc nxtfr_event public API
%% @end
%%%-------------------------------------------------------------------

-module(nxtfr_event_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    nxtfr_event_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
