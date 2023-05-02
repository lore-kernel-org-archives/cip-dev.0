Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A195DC77B7E
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 13:54:40 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by mx.groups.io with SMTP id smtpd.web11.129159.1683034644534328539
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 06:37:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@web.de header.s=s29768273 header.b=kZjtkWrS;
 spf=pass (domain: web.de, ip: 212.227.15.4, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1683034642; i=jan.kiszka@web.de;
	bh=MjLwb5myqpLErwQm6lvI0aika2fv9VgAiokT0Yqn0iU=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=kZjtkWrSsItOsRRYkuT/q0iBGSLDF5WPJdwDW74PVFdrbzJE6f8U61EmuScTMWiuU
	 QqUoCv5h6Lr3f7eOwRoye8VflAKKIi58a1Hn+/Uf2Gc5Vceu/Z2R8Ng1HW87NuG1/s
	 wxaH5TDgn1/plDt+L8TxSAOMmt1Sjo1OC/qRw85IxHBdGTqlDB6Beg82GMt59QudGP
	 uMPRRoQzb5bye3PWiB0Ex/zV/9YGqcUT1U3OeHBfOiHfc31MRNPNuCaFqLkjGO7Z6n
	 hNybEvwSwNB5X7XHoYsEtlmhUtAHtJ4T5mZJ8lgfH47+pKunW5QKo8lmohz4wgcg8G
	 S2iGlIBSyo6Vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([92.210.1.46]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMpCS-1pdPnx3W7g-00J6DY; Tue, 02
 May 2023 15:37:21 +0200
Message-ID: <2bf16d2e-7c8d-467f-2f72-3e0925536dbb@web.de>
Date: Tue, 2 May 2023 15:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Pavel Machek <pavel@denx.de>, Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: 4.4 localversion-st
X-Provags-ID: V03:K1:mGAZINzc9xHmUb7v+UK9F9YPXwHSQ7r9dUUnI1way/56lCu4A7D
 Nvc0pUuXfAEOdKrv9WNUL5Nqa/ql6BfGG8CeDmuCL8p3UtwQy/33+fqBDCxKjcMrun1dfba
 vuPOffUCxjjD2EpTCsn5G+07y4XZbFUdw8X7uSi/jlim05STJm7aOXPNKmFM4zTJeTsSkt6
 WOnZEnshTvqTQcs2Mpu+Q==
UI-OutboundReport: notjunk:1;M01:P0:+EGsft4Oy5U=;z5kynsr/DLQZ5xLvl+G2n0a7Mfo
 fxmNNf80QXLAjxt649nd1tIrlgVCJ56xih9Tgka1lWdylaY8BB0GhFh2VgwiGm5SS/isokXKB
 0JoB64C0TR9zjRt4U9ZHmWGpoNff1JGA8WT3EW/sVVEqiRvP4FvVbJWlX3pWulGrWeX/VZB9h
 nFcoQeYSYoVOhQ7ba2MaE4aiu1o9bH3u2p5zCTIeSD7zIKonZAbS6N1AfZ+PH/74/r6zruRzV
 mmlIqYAJkpuHMVyDHWpfP7OG7zFUxIc0phADBzQ2wUadjdUFOYWWYA0wgk95GeZ8qxysGh/gR
 xQ77CF6FAX0rualTJN9yjyXBQIJklyNs9SZ14JAOysZoX2RICCnUq4rwiR7zaN2G7rQ6UePoA
 oBKosMD7yczaS/n9k1Bc/iq4lphlm/9CA974nWZfmAvH3xJurlKs9OqKUeLTqHaPqrtL1JjdF
 3pA2A/DAPy3+LlkW7T7zz7Qp5EWh9FdDr4TaO+lex1XX8HMrNpU88x/+q3hAgZnPZG5OdPCrN
 DvEOsMGQ2qwxaV5Z6wf0LSJqlG+rbNlnvd8ux2x3j7th6B65dyPPZONcPktsbZr+ePGz5PGIt
 1QyP8gYjDeYonnr1PQyzmM/cxxPcJ90rh7+9ejygh6726faR6Crxo6kn0ZIbKd7X4cpE/7Dmc
 LzAq3xeNDNYryOqVvsUQMHXQVtABughMmdoCjvNh+R73iJ8ooqCwbsz/lK/D0T/5+lLyRJl90
 j3w2kYuXwam3LbqQsa51CDf23tL07TseEeE/WOfZxea3YG5L3RE6mfxh2zwyZTTdNR43tKkIN
 49rmGk5ELQ7m6fzZkpyrOZT2rCC75GOAITHLB/5QhBNG2z/frkUyAmFW6IsoS9v2zPgntwx4g
 PtxZjjVxPhgoXj7X+eedXwGgVOCNtsSWTg8wmR1RPeZeMONZnry0RBy1I2O9GcdUrMpkWnXu6
 3Ks71I4v3CCiSv/NSnT3LS9H++I=
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 13:54:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11377

Hi all,

I just noticed in some error message that our 4.4 kernels are reporting
themselves as "4.4.302-cip74-st39", and that extra -st39 is coming from
localversion-st. Is that intentional or an accidental effect of merging
the -st tree into the cip branch?

Jan

