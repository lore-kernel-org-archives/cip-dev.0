Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034AFC001DB
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 11:36:16 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.86])
 by mx.groups.io with SMTP id smtpd.web10.14949.1691667368174348646
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 04:36:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=e7dPGScy;
 spf=pass (domain: siemens.com, ip: 40.107.247.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTXM2FqqlRcpokOWkz2UGiu7kbbrE0d8MX+Kb2SezEqLH6mx6SZ0cl0J9T/287CryFv18GluUbbGL7amICYdRS+ZkMimkZ05wmjl6UiNkc25/bmGUwvWUEliYy7xdDXkMYMJY/vq68z3x08ZGwGmy6/cEeA9nGuaqo+z+OlKFfpfer+yvEfhV+nVblx3ijvxoMAqLhOGw9fHsLy8Zb19z6kU333hgI30GgRj7ANMfJRmYx0wZ+AhcsCLFe8ku5S2jZYT60alNMPtWUPO2Gm507RYB/J3AT02ovFC0oSjX/zdcbEAmNGt6RvCI6nHkTwbEWmL/uYOT8MY0RI6DwBcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+uWRX+mD2r9S7OFZsK0jRpYp07lEx87nVw9LG3kJTo=;
 b=ZPLB3IamwfSTW0+zUU8+hE/lBR1ZQjbJD7cyIO1Jq6lAZpZcw9gTYDgUx9ILJxox+4I1LMyPsrX7cbf6EU1DHEzZ9h7+9oMQ0XpohfT0AmGcBwqqS7UtdM5Oaj7M8wl/1OGqrDm1llxraqNzgfCbMtps+fakRpNIL7nnaRRUEjx1wWksaRC2p1jPwCHazOXot/VTDb4aDOMzelNs+MPZbsX/VXcCZNJZL1ZqoI9yohsHTXEe6mqSA9m8ukfMnusNzwOOYgN4md2x4mV+HfuQmetMqER4u00/aW6eqFyCdKHPVFFYKLjOVhUGIoN6mGS6TaR5z67DtahLtlegKy55iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+uWRX+mD2r9S7OFZsK0jRpYp07lEx87nVw9LG3kJTo=;
 b=e7dPGScy4sXQ3BrzmVkjNWwYpmGqw316ygIQWAFVckejFRzgomZRPSq1KbSRKBao7pPh/1FwiYLi+PW62CMt6vb9774ypvV2jLu9Gib3F/NY2Zwm3nTjyOwuaeNzBig0lMhTAx75oZoU+TbS9E0JEBrLNolZArVPJkDa/mJwuDNNYJt6o+PRtE8dyIZ1mQn0XqSB2xd4xrMoxMwE5sK2LDhg1W+dNRIZtR/n31N11j6kMsw1QjLWbdli9LH6U0+Hup91/wQF5R+AIpFspP8Z60XTM8KrvQhqkPuHrv3ghvJtBKHVElV+3tVn1bkBdCkDqqfpTMFMrRGx7e10MX/ouw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:36:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:36:04 +0000
Message-ID: <73ae4d03-8556-4b9f-87a5-17b7302108d9@siemens.com>
Date: Thu, 10 Aug 2023 13:36:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] swupdate-handler: Add default
 config to fix u-boot build
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org,
 "Moessbauer, Felix (T RDA IOT SES-DE)" <felix.moessbauer@siemens.com>
References: <20230803102401.564807-1-Quirin.Gylstorff@siemens.com>
 <674bbcf8-8246-4faf-b80b-f5f672315492@siemens.com>
 <81ca5a8d-4b57-c71f-651d-fd5e01176661@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <81ca5a8d-4b57-c71f-651d-fd5e01176661@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7fe291-0bd2-4a9d-9c35-08db9995fb46
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zRzVfa6o9eG3YLOC/s9rq9Zp6M5hu1UXLAzFNqhnHcduCfWHRh19cnKcTPOlWzfeTUH6VR1i5/wNIsGCHsvotVdfI4pk7wTtTOUfj6kroJLdPZF7MKKLen7Hi/HEn5VFtBs2btR8Tm7iOvFNzWmcs9JKcpMSgF/PQbe6nNTrA2mrgTWLxqk0J/FD8EmVh2A3iGS+sDMBKgQFjN72j5j8iu7AJn4RpM0qJN/iFZQoFcx/mjpMtCs9LyDEdk84tJ3bzVi46pfItaIQOLiBE1ezzJLWoJAhi+c72Pp/cXRcEV5RxI23Fl6brkuuvCK/pcO4mCYQ5WYuoWwzrSWZgi4yWm3hZB16vb+cE/CWWxd3i54rTER0yFAjDLVEv1PCBXzXAXewugJqO/oYBykaFg3/lxZDjDgQS+Ze2FoUokHrk9X3fk9l1FyYxekgzRPTKAyP69n05uDQUDzlnGCMnvniTG7pPrDCzidSUjoTMAEJ8cavZZMtTm5l6T9g1Z9N7kGoaJW8SBpn1GvaM8wa9trD4R15jkJ8aXJEoOhICqPJnV0TiBgXfCVidqRV14IbKriK/DUV6+NEwAoEZxCktE4zB6Ua5Ue9bfE3+hzh+wTZy0D9GKd0WybX8vOZVLQr8Am60lcgxTRLBB6BPOe3DfFtxg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(1800799006)(186006)(31686004)(66946007)(66556008)(66476007)(38100700002)(6636002)(83380400001)(316002)(8676002)(110136005)(8936002)(82960400001)(41300700001)(5660300002)(6512007)(86362001)(478600001)(2616005)(31696002)(44832011)(6506007)(26005)(53546011)(36756003)(2906002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nhfreXafwYtRmAVpkyla5qVjJklSUs80nIDu5smxJQXwgy4Fl9vOytA47dG1?=
 =?us-ascii?Q?P0xEWwESE5j1+gip2yxPka5Ed8Cl9mFo33OiEGfEw8ax+oxKJXF9vIMYg6TQ?=
 =?us-ascii?Q?eI0qEk8Q3SvtdZ6arJi8h3PxqFT4GZ8Infu/PYBF+F/OaT1HWtrtQaZddORT?=
 =?us-ascii?Q?sN/MiyO6bH3oKgbEx4TH/tYgZqcvgfAQkIy8/cET+jg52uXNBIYQCj3rNlv5?=
 =?us-ascii?Q?UzZcVhgu5OChoYwOUPp2EaOwNORTAtAEvFkhQGxTmB7MfbbMV3TRN20N0bx/?=
 =?us-ascii?Q?pYMuePa36c2gJs9n4wuSQHLoGj3wE32vSLOUV+B2MJ334YJB3POwIuYTCJxH?=
 =?us-ascii?Q?PNT05QwYGD3SmYKp7vdPz/IYC4aTh8UZDKxM7NgATKs97fcqrVj9zmlaYgG1?=
 =?us-ascii?Q?gehKyRrrlasyp68856NmdFf/iZDlx408Of4XGNq3GRPZovHs9CsxMJNrnWA8?=
 =?us-ascii?Q?2bHHkNuMYrwwqqgskt2HkbD9UnwLIjjxM1pcbyQwrl0yLf8DcTc9Zoxtr0LY?=
 =?us-ascii?Q?kHSXpKhYiGuAU9RgdNDqlW82ufbxMYOLYI+H/hq2VbgWjp5lDFGtUizzajvy?=
 =?us-ascii?Q?RIMHXft5Dfz450ZKZYaMa9vXHJ4mXBOG1Zkf700ZbIbJNx2KU/ABuGPv9a6f?=
 =?us-ascii?Q?TUqdUGt6yUc/Cl02mBMTivPY541kuTtm+GMtuNGxktqzVJhFtHHr+3iDKris?=
 =?us-ascii?Q?Y+P0JBrfaTainxHlb0EhjRbM/7RtdfoYoDsSa2FlWuJ7vHzK/BoQYDFdE+Ii?=
 =?us-ascii?Q?9LsOTpj0SfRpwfO6OD4M7mmtQW7XsQ/RNW2onQ3qXJaBDhPxzIRVGfCHUEPV?=
 =?us-ascii?Q?VUdlASxSnhUsi9CoCroS16sNk6z8smSV0iZr+aDfq5ZKTEsKp7R3T6Ne+3WZ?=
 =?us-ascii?Q?va7MQ8N+dFuV7S+q5aUozL9gKjlke3Qu5UVN/5lcPlDWTpnx0iOf8q8QdoHY?=
 =?us-ascii?Q?xS/F1RjouqgZj48yGkiwpRBa7e0ibiv7SUG8fcqkUErJGBvPxSCm+aup78iV?=
 =?us-ascii?Q?1aG/drS2yR+KkrGlCntsNBmKOdGfOBB70C5gAStu/1q6xgUhaoT9EDduhDwu?=
 =?us-ascii?Q?QOvbYmz6/jaFDqgBND9jdDTD/QLRiwMIrej8BVEwbWt8UsDZRIEShZ0zGST5?=
 =?us-ascii?Q?q8GecMltNZTR97M5zgeRHsxrq5LfsX+hCyEYv9s5LP4Oy5pZ6M87THR/fkR0?=
 =?us-ascii?Q?1tHo6E1JfuE8bEMF9WYgzJgZDHgA4NDeH6U8VU77+eU0BJU9YQJtptB1cepv?=
 =?us-ascii?Q?FOrG9+FHVAhxJv4TdUBCiQMp67RUzssWn5nfg1MollcXGy3lRAsNmUqmLyEj?=
 =?us-ascii?Q?LlniDm5dSKA9K4VtnLRx0CUeD/hyTEZo2o6Z0aiHxlIAkCoR4hxMw77iFxf/?=
 =?us-ascii?Q?cdhVirTJMPEmtNsln/Mqel2QT5dvllCfmzWw1sj7Ajqi1URx3Yvys4NK7Drk?=
 =?us-ascii?Q?lrHqs0PEZTvVC+SWyxk974ARx+mgQ1sQRHa0GXCGZloyBRfXiyZLV8wF5rPp?=
 =?us-ascii?Q?NcnO/Bl7IGAb4gn5m5FHpB3mE5zXmNhU38E7wvsp2o+EEhFbH92IQ6wRi5/Y?=
 =?us-ascii?Q?UTMfzBz0SxXCI8bzauMGl3roZiQVSYL3m4uY7WapC3Xutigw1WKBbVfIv2Sv?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7fe291-0bd2-4a9d-9c35-08db9995fb46
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:36:04.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eLpHgYKJ/Xhnh9AYFE4ThEDGxrRKGXnDqVjwmwUDuU/Hgtta8xqO+C2WwG4jlSQcs4UPIx/xOit6bIjx/EEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5781
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 11:36:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12601

On 10.08.23 13:26, Gylstorff Quirin wrote:
>=20
>=20
> On 8/10/23 13:01, Jan Kiszka wrote:
>> On 03.08.23 12:24, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This adds the missing configuration file to allow to build with u-boot
>>> as the boot selector.
>>>
>>> It uses the getroot mechanism from SWUpdate to select the update
>>> partition.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> CC: felix.moessbauer@siemens.com
>>> TO: jan.kiszka@siemens.com
>>>
>>> =C2=A0 .../files/swupdate.handler.u-boot.ini=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 10 ++++++++++
>>> =C2=A0 1 file changed, 10 insertions(+)
>>> =C2=A0 create mode 100644
>>> recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.=
ini
>>>
>>> diff --git
>>> a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boo=
t.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-b=
oot.ini
>>> new file mode 100644
>>> index 0000000..0e6df08
>>> --- /dev/null
>>> +++
>>> b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boo=
t.ini
>>> @@ -0,0 +1,10 @@
>>> +[image]
>>> +chainhandler=3Draw
>>> +
>>> +[image.selector]
>>> +method=3Dgetroot_rrmap
>>> +[kernel]
>>> +chainhandler=3Drawfile
>>> +
>>> +[kernel.selector]
>>> +method=3Dgetroot_rrmap
>>
>> This is not being stressed by isar-cip-core, is it? Do we plan to add a
>> target that uses legacy u-boot script-based a/b switching?
>=20
> I had one request by downstream for supporting u-boot with suwpdate from
> cip-core.
>=20
> Without this file the swupdate-helper will not build if U-Boot was
> selected as the bootloader.
>=20
> If there is no plans for legacy u-boot a/b switching I would propose to
> remove the u-boot code from the swupdate FSTYPE.

Well, if there is more than one request for that feature and adding this
file here would be the only reason for downstreams to override our
swupdate-handler-roundrobin recipe, we can take that (as "not tested").

How would the situation change if we get the handler merged into
swupdate upstream?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


