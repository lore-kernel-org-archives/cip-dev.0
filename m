Return-Path: <SRS0=5i49=7A=lists.cip-project.org=bounce+64572+4627+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0659BC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 08:35:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F6C20657
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 08:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QjTxjQM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F6C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4627+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JXaIYY4521723xFdVqgmzoj8; Mon, 18 May 2020 01:35:58 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.37604.1589790956289868881
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2020 01:35:57 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 04I8ZrG3001180
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2020 10:35:53 +0200
X-Received: from [139.22.125.205] ([139.22.125.205])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 04I8ZqgI016044;
	Mon, 18 May 2020 10:35:52 +0200
Subject: Re: [cip-dev][isar-cip-core] Integration of test and security dependencies with cip-core
To: cip-dev@lists.cip-project.org,
        "daniel.sangorrin@toshiba.co.jp" <daniel.sangorrin@toshiba.co.jp>,
        "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
References: <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <OSAPR01MB2385B768C9B6FF689451C626B7B80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <83617f18-4aed-f6cb-6ba6-2cb8e274d5be@siemens.com>
Date: Mon, 18 May 2020 10:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB2385B768C9B6FF689451C626B7B80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1XhNTmuRWbcDVEIGnQhyhcxgx4520388AA=
Content-Type: multipart/mixed; boundary="mXeuzArYVGKjSJ1YPEca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589790958;
 bh=k89Z/KeAYO5lyeY7bvS2U0zu6KGXWHYV8UDHxh7BfuA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QjTxjQM73P4z1V2OgFrkSdlrF72FoQJ+0XvM/56qCNWJMUYeOh8yxSXLqHCWRj5jr2b
 oO2lzIOzPvL83j3GwkSZPV9K2YRw+AoJrEX1p5Slm4EqI6zx9D+NenD9Q9NJL2Ds3RDiH
 mqUaso5MaNqx1hka4B8YuUIjz1QaG9Qsb3g=

--mXeuzArYVGKjSJ1YPEca
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 5/18/20 10:10 AM, Chris Paterson wrote:
> Hello,
> 
>> From: daniel.sangorrin@toshiba.co.jp <daniel.sangorrin@toshiba.co.jp>
>> Sent: 18 May 2020 07:37
>>
>> Hello Dinesh, Chris, Jan:
>>
>> # BACKGROUND
>>
>> As I mentioned in our last technical steering commite meeting, our gitlab-ci
>> scripts should be able to produce multiple OS images. For example, the testing
>> team needs to have python and possibly other software including the tests
>> themshelves; and the security team needs to have extra packages and probably
>> lots of customizations.
> 
> Thanks for starting the conversation.
> 
>>
>> # CURRENT STATUS
>>
>> At the moment we have what I would call "target images", which contain:
>>
>> * something close to what I would call the "CIP Core Generic profile":
>>      * the ISAR core packages
>>          * I think these are basically debootstrap minbase (isar/meta/recipes-
>> core/isar-bootstrap)
>>      * some extra customizations
>>          * https://gitlab.com/cip-project/cip-core/isar-cip-core/-
>> /tree/master/recipes-core/
>> * target-dependent packages (kernel, u-boot, firmware, etc)
>>      * these are added using KAS opt.yaml syntax, instead of using a meta-layer
>> * options
>>      * opt-rt: will use a kernel with PREEMPT-RT patch
>>      * opt-stretch: will use stretch as distro
>>      * opt-4.4: will use kernel v4.4 instead of the default 4.10
>>      * opt-targz-img: exports the image as a tarball for LAVA
>>
>> On the branch, iec-evaluation there is an initial implementation of the security
>> image:
>>      * https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/security/iec-
>> evaluation
>>      * at first they added an opt-security.yaml file:
>>          * https://gitlab.com/cip-project/cip-core/isar-cip-core/-
>> /commit/a8216d4ca5eed4d73dff2e00601dea7c9d733f45
>>      * then they changed to use recipes-core/images/cip-core-image-security.bb
>> that extends IMAGE_PREINSTALL
>>          * https://gitlab.com/cip-project/cip-core/isar-cip-core/-
>> /commit/3461a50297e370210d76d85d434fb625c8c4248c
>>      * see the original thread here:
>>          * https://lore.kernel.org/cip-
>> dev/TYXPR01MB180817C883F874B321DBA264E1FD0@TYXPR01MB1808.jpnprd
>> 01.prod.outlook.com/T/#m752a116d8372222d727722f4fe18ca19d94838eb
>>
>> # MY PROPOSAL
>>
>> My proposal as the next task for the CIP Core work group is to add metadata for
>> releasing these images:
>>
>> * target images: isar debootstrap + customizations + kernel/u-boot/fw
>>      * [NEW] release them as bmap images for our reference hardware boards
>>      * [NEW] create a page (gitlab wiki) that will contain links to the latest images
>> and how-to-install readmes for each reference board
>>      * [NEW] refer to that page from the CIP wiki page
>> (https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/ciprefer
>> encehardware)
> 
> All +1
> 
>> * [NEW] testing images: target images + test dependencies
>>      * release them using opt-targz-img so they can be used in LAVA
>>      * add the test dependencies
>>          * packages: python2.7, python3, ...
>>          * tests: LTP, ...
>>              * method 1: build them on a separate repo and include in the image
>>              * method 2: build them with ISAR (new recipes) and include in the image
>>              * method 3: the artifacts are downloaded by LAVA <-- My preference

> 
> By "artifacts" do you meant the entire filesystem? Or just individual test packages etc.?
> 
> My preference would be for the whole filesystem including the test packages to be built by ISAR, then LAVA just downloads the 'latest' cip-core-test image when running tests.
> 

Only as info LTP is part of isar-cip-core in next since commit 
f84a815dc6969eb2b0b276e15c8fce2d52937114


>>          * How to implement this
>>              * method 1: using the opt yaml format <-- My preference if we only need
>> to specify packages
>>              * method 2: creating a separate meta layer
>>              * method 3: using a new image (cip-core-image-testing.bb)
> 
> As long as the 'standard' cip-core is included/inherited rather than copied I don't mind the method.
> This will reduce the maintenance burden.
> 
> Kind regards, Chris
> 
>> * [NEW] security: target + security packages + security tests and dependencies
>>      * release in two formats
>>          * using opt-targz-img so they can be used in LAVA
>>          * as images for our reference hardware boards
>>              * add to the gitlab wiki links to the latest images and how-to-install
>> readmes too
>>      * How to implement this
>>          * method 1: using the opt yaml format
>>          * method 2: creating a separate meta layer <-- My preference if it gets
>> complex
>>          * method 3: using a new image (cip-core-image-security.bb) <-- Current
>> method
>>
>> # FEEDBACK
>>
>> Please check my initial proposal and send me feedback.
>>
>> Thanks,
>> Daniel Sangorrin
>>
>>
>>
> 
> 
> 
> 
Best regards,

-- 
Quirin

--mXeuzArYVGKjSJ1YPEca
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4627): https://lists.cip-project.org/g/cip-dev/message=
/4627
Mute This Topic: https://lists.cip-project.org/mt/74286250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mXeuzArYVGKjSJ1YPEca--
