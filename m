Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07FDC433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 15:57:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.83])
 by mx.groups.io with SMTP id smtpd.web11.12217.1639670244323878690
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 07:57:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w6mvw/Bs;
 spf=pass (domain: siemens.com, ip: 40.107.22.83,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGVADarTVSIx34ZWX2jrOvru+uWejVAziD2ikk5eK1aHv2OgT69D8i0z3wxLEZD+fYcCcDdBob4oROYrQJKMsLK1T8li9zNIlN70x9DG3NBBb1QyJZLf/Qs/HRZUt9O9N4q5rtbUMQO26ICmCx2eP2ATi2qepEy9vrw11h16Y8IhJTOMVkiEWz02PzIuZOSwwjukiIzwWry+mwdjp8Q0X/U79CcrmdVwHAFuINg8gO644wFF97TeQ5TlrjpHrPyubAHFkiZCZAdj/OFctk2g4vFYTTNRlCv6fl8gVK8IOz3mJh3NGNeFyM4J6FOSm9FBuco/XpjNrxm8Gax7jGgZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJfo87iBHfwncqHubR41KDGL8Bl2c6DjpymlX9e/qBc=;
 b=aCne4u53gNNzfYualaUgzA+2iQqzBAVnfzaZdDa37UkSTyBoQ6XldYmM+KBGOF1zGWnwmtpVbv8SxigBlyb5rMQi66vvej79jdS8iuXDpnvzNZp1+ESOCbXUFKUFMP8d3DNMDfgtYCjJZAelceqk5lJSnoXmtMkidl6rsUXJOYxfjmeux6xKQ7aba2O3COa6SbBg8HvfOawjodMcxwtokRr2NmZVElQ2YfKsmOq8UAtEEtihCtlDBrVDM245XGV4Moij/tpEBYFnT6HPI6xhK+gvuuunqg02G8l2Utkh4KdAVrfHzsFi+eIK4qM2BITJsrc30V41/YYmmZoDzNuUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJfo87iBHfwncqHubR41KDGL8Bl2c6DjpymlX9e/qBc=;
 b=w6mvw/BsfOV4OjzwFpD6NRjnlDUpQQ2LtRPewOLtQBE5YqYIy21pBWZkMORXEYdQHIBW12ZViZaiRDZE9Q6fzpuRqUf9LsWSm5N9KtR/QikQZP5jmv9I95Lxu9HiU0Rzr9O9erBaAYFUoZfHABSYfBS9YJUFHl/gID5iWdyxh1HjdwbbMetR5WmEP9YYp8Qjcf5/jAQEh8wA42wa4gXsU7q8xHPAn9WW6rLLp5FiQWnXpFqOhQaNIgIj+2p0bhsiSFndUGzQ+ry8SEGccjawPe691DNWSLr5SbyH+Oi7X34JjedC7HfLKPmIZdTsfD50M7ZrYuH/LVBY2VcpmKYANw==
Received: from SV0P279CA0061.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::12)
 by VI1PR10MB2032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 15:57:20 +0000
Received: from HE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::a9) by SV0P279CA0061.outlook.office365.com
 (2603:10a6:f10:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 15:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT050.mail.protection.outlook.com (10.152.1.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 15:57:19 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 16:57:18 +0100
Received: from [139.22.140.88] (139.22.140.88) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 16:57:18 +0100
Subject: Re: [isar-cip-core][PATCH v2 2/2] swupdate: Drop conditional includes
 for buster
To: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Quirin
 Gylstorff" <quirin.gylstorff@siemens.com>
References: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
 <20211216133617.3403412-3-Vijaikumar_Kanagarajan@mentor.com>
 <2ce1cbe9-8950-f136-d7a5-b97b455e8105@siemens.com>
 <518bb7da0c0a4e70912e3dcbcdcad06b@svr-orw-mbx-01.mgc.mentorg.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <07bc3081-88ae-ef1b-cef4-4d00c0ae0703@siemens.com>
Date: Thu, 16 Dec 2021 16:57:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <518bb7da0c0a4e70912e3dcbcdcad06b@svr-orw-mbx-01.mgc.mentorg.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.140.88]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef45e55-c6ba-462f-df74-08d9c0acbd42
X-MS-TrafficTypeDiagnostic: VI1PR10MB2032:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB20325A1E295F8351EC34D61295779@VI1PR10MB2032.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k9iCbhvfgsxH10XzF9nPzouvXOrlmWVty096yL4sfOVEqonRCXxkum23DJ1t2gWzxfQtUHgVW69BsyLw0DglvyQe+JIUsEweYBO3ApYEYrjHZDv7p/wynPxDvlJRWeKHkUYa65IA5kND3VKEmvXvBg6t9x/eR9YdfXTJkjGSEKtsvSsI7bfk2o7nLiCP0v95wxj6P6eHId+3+mFQkR3Ha66bKFpGt3PVc4HfOsnBRam1o/WbNe7WTUIvMPFTGWoKSYl0zU2P17uWlft4AHNQo+kwmhvZcgeSAXHEmWCFq9drW3arSajjM6EEyhp5tzxbvURQXVOOXoeKQp3+5Ir5oK9PBpxgBZDLgPnT9LmrmY83nsgIq3SMdeD/Mc3fH8Ar9w7QQz7eutE8UKoxKfVm1ZGA+VwWBiVApSvsIfp/n/Tvt3uFY6sropnQhLaH9yBNV+SL6t3MyXp1nyLeG88zEVGDRHYaSVr7B31QjuL83w/6gShAZcSP6TGFyz1lmZgG1i269Qoof3mlTofISDXevt1GF9djekByfp17C1oeqy+xcBN2qVnpUWSrAuy0e+EIqO+oUQtsjqa4nXcrlB1oG1vTiwtriMlRZ1aPfM6MjvmIMRu23hBkgkUwf0QHUTSg40CSfb/P3LzBI5HvupFeHSnZfoKlueyEA3+pUjO8cRzc4cukx2djn6XuBE7iaHWBrlotJLx4BgatClHdEByuvbpZ12k4V7w7bxA4InUF4isQ6E9KshdW3QVhVzG/meuQ9PjLhYvoTHveVa3uRWk6yojL/ZIbtcBelJR5FgAQhZwtGVqyyLsAuOTgEBDQIx06M3yTrKStY8LjIos7x8Rbaw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(82310400004)(956004)(6636002)(36860700001)(82960400001)(2906002)(31696002)(70206006)(7596003)(7636003)(47076005)(16576012)(70586007)(336012)(26005)(36756003)(31686004)(110136005)(498600001)(8936002)(2616005)(186003)(16526019)(44832011)(83380400001)(8676002)(86362001)(5660300002)(6706004)(356005)(53546011)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 15:57:19.1038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fef45e55-c6ba-462f-df74-08d9c0acbd42
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2032
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 15:57:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7162

On 16.12.21 15:23, Kanagarajan, Vijaikumar wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 16 December 2021 19:09
>> To: Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan@mentor.com>; cip-
>> dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH v2 2/2] swupdate: Drop conditional
>> includes for buster
>>
>> On 16.12.21 14:36, Vijai Kumar K wrote:
>>> Stretch in now dropped. The conditional includes for buster is now not
>>> needed. Those includes are applicable to buster as well as bullseye.
>>>
>>> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
>>> ---
>>>  .../swupdate/swupdate_2021.04-1+debian-gbp.bb        | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>>> b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>>> index a4d67fe..51aacfe 100644
>>> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>>> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
>>> @@ -44,12 +44,12 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
>>>  # modify for debian buster build
>>>  SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-
>> debian-buster.patch"
>>>
>>> -# disable documentation due to missing packages in debian buster -#
>>> disable create filesystem due to missing symbols in debian buster -#
>>> disable webserver due to missing symbols in debian buster
>>> -SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
>>> -                                          pkg.swupdate.nocreatefs \
>>> -                                          pkg.swupdate.nowebserver "
>>> +# disable documentation due to missing packages # disable create
>>> +filesystem due to missing symbols # disable webserver due to missing
>>> +symbols SWUPDATE_BUILD_PROFILES_append = " nodoc \
>>> +                                   pkg.swupdate.nocreatefs \
>>> +                                   pkg.swupdate.nowebserver "
>>>  # In debian buster the git-compression defaults to gz and does not
>>> detect other  # compression formats.
>>>  GBP_EXTRA_OPTIONS += "--git-compression=xz"
>>>
>>
>> So these things were actually broken for bullseye so far?
> 
> Yes. Atleast, the nodoc is needed because of sphinx dependency issue in bullseye.
> 

Quirin just told me that only nodoc is needed for all.

Dropping this patch again (keeping 1/2 though). Please send a v3 which
does that, ie. adds a _bullseye profile and keeps the existing buster one.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

