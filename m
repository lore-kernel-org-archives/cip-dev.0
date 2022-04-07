Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01796C47087
	for <webhook@archiver.kernel.org>; Thu,  7 Apr 2022 15:41:15 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.63])
 by mx.groups.io with SMTP id smtpd.web11.5696.1649332002232477986
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Apr 2022 04:46:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=pNwXF5Ux;
 spf=pass (domain: siemens.com, ip: 40.107.21.63,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzVCIjzZefnCfDpFBn6atAf9ISyZo9HmDzfH0ID/paX3O7OoQ/7lHxOGVr9NVSlIq0DOiPpb3um6Y6KwsyNDQiHyYhfWA6pSMELHVUggdg6D8aPkVeiyPxczlR+qh/TFs4hXPD7ul0Q2n+B/t2exbEc5K//hjoGGTpRoYUcwnqJ4RZrP0sgEpSMdhTjNgMLvbphfj0kwfTOquYftolCBBE0iT3c4tBRug8tXCiXnPD0I8Q5XVB5I6PuOyhVmg71VW/Gl/DBbGGaQ5ljGYeKizPPujr9TJwaRcDFHunoMLtF6VFqkuvHqD3ayLcebrYhTlZ5WqmySLy3u3gPRS5jEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3Z7z+g1wyz2Vw1aOaUu82MbGoXlfCJ1Cvb3LT+l3k4=;
 b=JFMIOzC6vrl47wQ0AJ6StvGJmFSr/FpPNeBDcW0nQjINeQ+tCH/3h2Mlh2eBynTU0qQBwGFsJYy3So4KicVr0Z7dqA/+15B2ERdcl6EbsL9OqN5sr8JxuK3+nh/Qc4vfVBESDX7maI5rvCFfCE4v1r7N34UlwdMCXWwrIaTm9FE3tKr01s2/1IU0mlsWtu9ay3lrz1lZn0slBBVBLW3Q4nOPR7mdncWiM4r+f3VdD+cy6sYFawt+OgGC1+ZDLdE7St7kz8FpJAtkcab1rm6KQeqsuHPpwAOuTX/4Y/OxckgIEJd0hVN7akPlLJ/A7WmYgPMOI/VBxIJmCVjpUDNktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3Z7z+g1wyz2Vw1aOaUu82MbGoXlfCJ1Cvb3LT+l3k4=;
 b=pNwXF5UxpJDNaBfCn17gqk+ZYRXHP1D+s64td8+HWIJ4H90h1OME92zUrb+P9AujidO1dodlUaQk6309gUroj9ZFm52G2CBIpgDikP3ZO8sfqqCtwg4jmLzziQC3fQCjCAeey6RXfLTcr15CbJ4hkMflvTlcnY3NWN8gU9nmT47CUfB1Qq8xSHRQnsj2xa+kul3FbSN92+zoddM93M1+PW1hmLB+ArUZT8748RkkH15ih3dut7iGu0BiCEadXwVsyfPd2lmJnCIHDSuJgupdZnyDCL9yrUbqt5hiSqB9jU4XEqWSwnatNChlf0JI727EnbeUoEEae6ZdtcNRTYIN8Q==
Received: from SV0P279CA0021.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::8) by
 AM0PR10MB2034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:42::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Thu, 7 Apr 2022 11:46:39 +0000
Received: from HE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::94) by SV0P279CA0021.outlook.office365.com
 (2603:10a6:f10:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19 via Frontend
 Transport; Thu, 7 Apr 2022 11:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT089.mail.protection.outlook.com (10.152.1.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 11:46:38 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 13:46:38 +0200
Received: from [167.87.32.126] (167.87.32.126) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 13:46:36 +0200
Message-ID: <4c9723fa-9661-ff57-9fb9-0c0d0c1f514f@siemens.com>
Date: Thu, 7 Apr 2022 13:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: 5.10.110-rc2 mirroring/testing
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>, Pavel Machek
	<pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
References: <20220406220612.GB4213@duo.ucw.cz>
 <b0523b80-b7ed-7ec8-2bc8-4a230b31f13b@siemens.com>
 <OSZPR01MB687707F1F7114CA3DEC73FF8B7E69@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <OSZPR01MB68776065BEEA1120B49C46B5B7E69@OSZPR01MB6877.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB68776065BEEA1120B49C46B5B7E69@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.32.126]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.987000-8.000000
X-TMASE-MatchedRID: 8fyaYowsvJ3/J7/cdz0rWv9x8ItM22K1Oa6H92+M9FQD2WXLXdz+Afio
	Isi7Sa0gOUu5w+Dw2fs0AUnua7sA95SPR9Gn3BGueOXVxMpW9TzcfstxMAb2qxIRh9wkXSlFuJs
	AFv31SR5X4H/AHZTAKmwVFq9KyZGWzfSIMQ7Ipw2QPpb+9jcjbJ76e9GOpfQKOGJyJBH/4NBFaX
	0GXRE81jYK8E4y4qO4zmbNi5wt5jT3QG06Kz+fTOPsEs7h7QqOOrPgsAyL7VHC0TXpqtexIt1hW
	sVVuzNo8f3rOEwXzqfd1FDAxsDME20vTDMVipqm/VWvko9pGMkul6ia+rpHwrU+IyHhkXf15RMD
	FPANjSh2g4d1d7AUduE7WdKVL1HLsCv538AJ1ukvHEcEx0NzujLvC8LxRzodb056mCmF00Zu/3B
	fmnjWTJY5iJNs3Fddo8WMkQWv6iWhMIDkR/KfwI2j49Ftap9EOwBXM346/+zJNY1RLdu/L64veJ
	9ByPdr5PKAY365QVoSbVQ7no8Rp/QOpTHa7Eed
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.987000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 06A8CBC106AEBE3CDA5E8FD7841837F2337683FF130B559000A1BD6F53E7DC402000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb1f31ab-316e-4a2b-da37-08da188c469e
X-MS-TrafficTypeDiagnostic: AM0PR10MB2034:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB2034E8D5A47C9752DE78307495E69@AM0PR10MB2034.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EEtnijC28S1a/A7rj/lUOdAXdqkCGOh3H0hLlOv17PxZGSr1VsJldUXEqiuIWcbHvkw8blHKD42fMnbbI44gyf5IAaGS3ckQsMFbqk+iBdm52dh5B91IVuOhpfeCXFvp796ZSDAsV9bYFBbExG0lgtRTxiKWH5qXCl77C4fgAliZAWpwAIr/m+ErSonciBRnjkK9SebYJXU3MTh3psN9qrjCUTPVLBgUXOV5HAHj1uHGP4PYRFhmy2kYf3ilOwkDhU8FsyAk1DECXnVI4Srr0FVOGMCzYupoVcQhThnQ9U8rHPC5mnUQ2R9FRn3y/Rb74tBRIL4IG/X7q6jFgHTMg7mXaIUStwQkjs32CuXwdzANmnBCMLVw79v/o3zdyrL5z0rFc6jQqV4cD2H0qgAAB4Io+Bdz812L4X5t8RpM9k49UKELFwvhIQ1iDdXzdOnTqBtM9Sihob2Bx7DPFCvMkxYc/kwBgAk5xBdQ5/QI0WZLN053KZg5/oLLA7lS419LkSCWeZahmBLHzPrbMxAOENDv0wyXNxKNgPK9Ck2u00IL/Y5bBr/eRXZ8WqX1RvdnzJM1TsgfP8Pr0Mh2Gb290URo508LY+tAKgGS8YlwrGR4sdY6yzoYXHuAHshnVSQJH6NQEbeHxfX/icEhpk7I/TxV61+LRCdA9JK68UlPMjTs4jCC0pv+Fjy1nF7ffhaCHZhKmfHt8oqTjHYbyzagwDjIyQeUZsZzTOLOaUk/Z1RROmw+dxcrcII7UA2ShXHruDJF4bwcM5JmB//Av892eAZkjXD0wOwo4ds1W2QuoIorJOfLghtd+d57BCap4EN1ukSlSAbuKmfdvpWaEaenwhKrUH8HhkdQn70fS0Gv61s=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(36860700001)(8936002)(82310400005)(2906002)(31696002)(86362001)(36756003)(31686004)(5660300002)(44832011)(316002)(81166007)(356005)(16576012)(186003)(8676002)(956004)(110136005)(70206006)(6706004)(82960400001)(83380400001)(70586007)(40460700003)(16526019)(508600001)(966005)(2616005)(336012)(53546011)(26005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 11:46:38.4868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cb1f31ab-316e-4a2b-da37-08da188c469e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2034
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Apr 2022 15:41:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8022

On 07.04.22 12:36, Chris Paterson wrote:
> Hello,
>=20
>> From: Chris Paterson
>> Sent: 07 April 2022 09:51
>>
>> Hello Pavel,
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 07 April 2022 07:44
>>>
>>> On 07.04.22 00:06, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>> 5.10.110-rc2 is out, and it would be good to test it, but somehow we
>>>> are still at -rc1...?
>>>>
>>>>
>>>
>> https://gitlab
>>> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
>>> %2Ftree%2Flinux-
>>>
>> 5.10.y&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.com%7Ccda7f53
>>>
>> 12d69483e751208da1861f34f%7C53d82571da1947e49cb4625a166a4a2a%7C0
>>>
>> %7C0%7C637849106225416510%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
>>>
>> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
>>>
>> amp;sdata=3Dp0tXQDyIDY1SqRyIOHrtFzygGDqTbRphnrVzn34XVy0%3D&amp;r
>>> eserved=3D0
>>>>
>>>> Does mirroring need to be kicked again?
>>
>> As Jan hinted, the mirroring has stopped because the linux-stable-rc
>> repository has now gone over the 10GB size limit.
>>
>> I guess we could  remove all the branches/tags we don't care about, then
>> protect the branches we do care about (LTS) and configure GitLab to only
>> mirror protected branches?
>> Hopefully that'll reduce the size a lot and mirroring will work again.
>=20
> I've gone through and deleted all the tags/branches we don't care about b=
ut GitLab hasn=E2=80=99t updated their storage calculations yet.
> For now we'll have to wait until they recalculate. Hopefully the repo siz=
e will drop enough.
>=20
> The alternative is that CIP buys extra storage, but I'm not sure if that'=
s done at the top-level for all of cip-project and the individual project l=
imit of 10GB still applies.
>

Or we could ask - as an OSS project - for extra benefits. Gitlab offers
this, we just didn't apply for it yet:

https://about.gitlab.com/solutions/open-source/join/

I'm not yet spotting if that would raise storage quotas, though.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

