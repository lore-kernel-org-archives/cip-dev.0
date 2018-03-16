From: wagi@monom.org (Daniel Wagner)
Date: Fri, 16 Mar 2018 11:07:23 +0100
Subject: [cip-dev] [cip-testing] Issue #167 - Build & test iw20gm kernel
 outside of cip-core/bitbake env
In-Reply-To: <CAEss1EK8ZXrCrtB4MxvW5FB0aqjzb7s=xyRcq0sSrx8eNrGvrA@mail.gmail.com>
References: <CAEss1EK8ZXrCrtB4MxvW5FB0aqjzb7s=xyRcq0sSrx8eNrGvrA@mail.gmail.com>
Message-ID: <713892e8-6a67-2bbc-d1c3-664daa214526@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Zoran,

> I have a gut feeling that some untested RT patch, influencing the iwg20m
> clocking tree, makes this mess. I guess, the ETH1000 problems are NOT
> the cause, rather the effect of this timing caused by buggy clocking
> tree iwg20m patch.

If you think -rt is a problem, test without it. Though I don't expect
that will be the source of this problem. When the -rt patch set creates
a problem the symptoms are quite different.

> I need to think more about all of this. The next obvious step is to
> start switching off/changing some of the timers' options in kernel's
> .config. To have bare minimum/simplistic/minimalistic clocking tree
> which still makes iwg20m platform to perform. In other words, failsafe
> clocking tree option.

IIRC, there was a working configuration on installed on the SD card. I
suggest you compare the DT with the new one.

Daniel
