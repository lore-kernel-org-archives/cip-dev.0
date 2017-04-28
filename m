From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Fri, 28 Apr 2017 09:22:08 +0200
Subject: [cip-dev] -rt for CIP kernel
Message-ID: <f9067de1-586a-18f7-9a99-ee7e4f2c3757@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

I would like to announce that I am starting getting my hands dirty with
maintaining the -rt series for the CIP kernel. I've done a few things
with the -rt patch set in the past so I am not completely lost. Though I
haven't done any maintenance work so far.

My first goal is to get familiar with Steven's scripts doing -rt stable
releases and redoing what Steven is currently doing for the 4.4-rt
stable tree. If this works out I might even propose myself maintaining
the 4.4-rt if Steven is agreeing on this. Though first I need to get
those scripts under control :)

There is certainly a need for discussing on what the cip-rt tree should
contain. I stress this because -rt stable trees follow the latest -rt
stable tree. That is everything which goes in latest stable will be back
ported to any stable -rt tree. I guess this is not what cip-rt is
targeting.

Thanks,
Daniel
