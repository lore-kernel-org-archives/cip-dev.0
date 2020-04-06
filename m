Return-Path: <SRS0=Wox9=5W=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F9C2BA19
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 10:15:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA542054F
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 10:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA542054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EB26A8844E;
	Mon,  6 Apr 2020 10:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IfqrkEK5pUOw; Mon,  6 Apr 2020 10:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 24B3D883F6;
	Mon,  6 Apr 2020 10:15:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A545C0177;
	Mon,  6 Apr 2020 10:15:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9F05C0177;
 Mon,  6 Apr 2020 10:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B894285623;
 Mon,  6 Apr 2020 10:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqpgKtrKVJyJ; Mon,  6 Apr 2020 10:15:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 479D083F31;
 Mon,  6 Apr 2020 10:15:22 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 036AFHRb022159
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2020 12:15:17 +0200
Received: from [139.22.38.89] ([139.22.38.89])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 036AFG1b028112;
 Mon, 6 Apr 2020 12:15:17 +0200
To: Pavel Machek <pavel@denx.de>, Kento Yoshida <kento.yoshida.wz@renesas.com>
References: <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <20200403214708.GA32080@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8d490687-c9fb-239e-5d01-55fec493168f@siemens.com>
Date: Mon, 6 Apr 2020 12:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403214708.GA32080@duo.ucw.cz>
Content-Language: en-US
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Python 3.x vs 2.7
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

On 03.04.20 23:47, Pavel Machek wrote:
> Hi!
> 
>>
>> FYI, unfortunately we couldn't find the alternative package for system backup. The duplicity is the best package for us from the license and num of dependencies point of view.
>> See the following.
>>
> 
>> <duplicity>
>> Encryption: Yes
>> Schedule backup: No
>> Incremental backup: Yes
>> License: GPL v2
>> Dependencies count (aprox): 80
>> Reference: http://duplicity.nongnu.org/features.ht
> 
> I'm not sure what your exact requirements are, but have you considered
> "tar"? It should be possible to pipe its output to aespipe (and
> possibly other tools) to get encryption, and it should be able to do
> incremental backups...

I suppose there is that concern about GPLv3 again (as with broadly used 
rsync) - which is generally overrated. There exists legal views that 
already GPLv2 requires to keep such licensed components replaceable on 
the target. What then effectively remains with v3 is its, well, wording 
complexity.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
