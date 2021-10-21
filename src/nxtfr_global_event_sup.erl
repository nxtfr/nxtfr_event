%%%-------------------------------------------------------------------
%% @doc nxtfr_connection top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(nxtfr_global_event_sup).

-behaviour(supervisor).

-export([start/1]).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    SupFlags = #{
        strategy => simple_one_for_one,
        intensity => 10,
        period => 1},

    NxtfrGlobalEvent = #{
        id => nxtfr_global_event,
        start => {gen_event, start_link, []},
        restart => transient},

    ChildSpecs = [NxtfrGlobalEvent],
    {ok, {SupFlags, ChildSpecs}}.

%% external functions

start(Name) ->
    supervisor:start_child(?MODULE, [{global, Name}]).