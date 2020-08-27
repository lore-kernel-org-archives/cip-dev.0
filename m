Return-Path: <SRS0=N2E0=CF=lists.cip-project.org=bounce+64572+5279+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA96C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:37:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A963920825
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KU7DgMvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A963920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5279+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gqDXYY4521723xRDzx2LToYy; Thu, 27 Aug 2020 00:37:02 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.13834.1598513821028014735
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 00:37:01 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07R7avlx021620
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2020 09:36:57 +0200
X-Received: from [167.87.79.124] ([167.87.79.124])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07R7atk6012239;
	Thu, 27 Aug 2020 09:36:56 +0200
Subject: Re: [cip-dev] Everything failed in gitlab
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
        Chris.Paterson2@renesas.com,
        "Adler, Michael (CT RDA IOT SES-DE)" <michael.adler@siemens.com>,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20200826072457.GA6645@amd>
 <TYAPR01MB29909A6D72BF6BF99367951092550@TYAPR01MB2990.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <12b9b0c0-7117-81fc-8360-a0bd858715a8@siemens.com>
Date: Thu, 27 Aug 2020 09:36:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB29909A6D72BF6BF99367951092550@TYAPR01MB2990.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ckgsJ6W8GQvfOqB96dDG2z38x4520388AA=
Content-Type: multipart/mixed; boundary="cg4e6w6YS59NiJfPQdak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598513822;
 bh=VRJ4RiB8Y7IZPklfvtNwlbBZCXZL3/IOWKxhg2Jb/Tk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=KU7DgMvE98ty/vFdMsAVM2fIQGDzYuU5sStHWPxs51m16M3VFe6KFcyEK8vs2KvtcYO
 obz6TFWFBhVNDVQdpeJuIqcAf224lj8iF2i+wOJAgntfeiAivEiBKf7F62PnCeF1unUcV
 QizCQPF4iuxiMO+8RCEPIrLAzx6Qt6/Y9Zc=

--cg4e6w6YS59NiJfPQdak
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 27.08.20 08:48, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
> 
> There seems to be a problem with kubernetes running gitlab-runner.
> AFAUK, this provided by Siemens. Jan, do you have any information about this?
> 

Michael, Quirin, any ideas?

Jan

> Best regards,
>   Nobuhiro
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.org] On Behalf Of Pavel Machek
>> Sent: Wednesday, August 26, 2020 4:25 PM
>> To: Chris.Paterson2@renesas.com; cip-dev@lists.cip-project.org
>> Subject: [cip-dev] Everything failed in gitlab
>>
>> Hi!
>>
>> I tried submitting kernel for testing, and got "everything failed"
>> result after timeout. I believe something is wrong with testing:
>>
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/181945390
>>
>> Any ideas?
>>
>> Best regards,
>> 									Pavel
>> --
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--cg4e6w6YS59NiJfPQdak
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5279): https://lists.cip-project.org/g/cip-dev/message=
/5279
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--cg4e6w6YS59NiJfPQdak--
