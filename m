Return-Path: <SRS0=ZUnv=5B=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A71C5ACC1
	for <cip-dev@archiver.kernel.org>; Mon, 16 Mar 2020 15:26:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA5B2051A
	for <cip-dev@archiver.kernel.org>; Mon, 16 Mar 2020 15:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA5B2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0FB0787E17;
	Mon, 16 Mar 2020 15:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rdFhYOG-znss; Mon, 16 Mar 2020 15:26:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC8A787DFF;
	Mon, 16 Mar 2020 15:26:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C211AC013E;
	Mon, 16 Mar 2020 15:26:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50C1FC013E
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 15:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3950E87E93
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 15:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGmlEGNSe3b3 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2020 15:26:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 74DA087E91
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 15:26:45 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 02GFQeU7009170
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2020 16:26:40 +0100
Received: from [167.87.49.142] ([167.87.49.142])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 02GFQcM1010798;
 Mon, 16 Mar 2020 16:26:39 +0100
To: vijai kumar <vijaikumar.kanagarajan@gmail.com>,
 cip-dev@lists.cip-project.org,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 nobuhiro1.iwamatsu@toshiba.co.jp, Pavel Machek <pavel@denx.de>
References: <CALLGG_Juuz3wktbc71uo68shAU4ZpaxKzAqycKtzKd0R4Meemg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8cc7afeb-409b-3dee-df4b-e6a63f979723@siemens.com>
Date: Mon, 16 Mar 2020 16:26:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CALLGG_Juuz3wktbc71uo68shAU4ZpaxKzAqycKtzKd0R4Meemg@mail.gmail.com>
Content-Language: en-US
Subject: Re: [cip-dev] Linux-cip: Kselftest plans
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

On 06.03.20 09:21, vijai kumar wrote:
> Hi All,
> 
> Is kselftest maintained in the cip-kernel tree? I do see some
> branch[1] maintained by Nobuhiro-san for kselftest, but it's out of
> 5.6 linux tree.
> 
> The reason being to gather collective thoughts about the plan for
> kselftest based tests for cip kernel. Are there any existing or future
> plans for using kselftest for testing cip kernels? If so are we going
> to use the latest tree from upstream or plan to fix/backport test
> cases to current cip kernel versions?
> 
> [1] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/tree/ci/iwamatsu/linux-cip-kselftest
> 
> Thanks,
> Vijai Kumar K

CC'ing our kernel maintainers and Chris in case someone has input on this.

Vijai, maybe you can say a few words about your integration experience 
and options to move forward.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
