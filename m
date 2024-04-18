Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E7CC4345F
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 10:21:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.9402.1713435690017940975
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Apr 2024 03:21:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 43IALRGi3582739; Thu, 18 Apr 2024 19:21:28 +0900
X-Iguazu-Qid: 2yAbXhlxNV0PxEAbOm
X-Iguazu-QSIG: v=2; s=0; t=1713435687; q=2yAbXhlxNV0PxEAbOm; m=kXfRw+DBn8r54s3POoa3IOPg27ZNzrJV23JMDj7LKjI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 43IALQQ3482348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 19:21:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZFaZn7r1VSJFh5Wd97T+LqMbbpwhK/xAJ3hkcDeysnwxXaLP+iqZGI3KzUbxRQGA+Ib5wPtHr2deLnWojglzDLvkDp5yudfgjeSPXZAePpw0TxI506TtdBfS5kMJ8R2xn6EF0kyuIJdSpAk9UH35yDFRh7rwyncrKIl5odeaZj44s4HODKXpOjxPxCKJsUhSrdhpPwTanXCuG52ReiCEv4vA/NpodWQC9eomw7tBSxvrW7GVAC1DCrfN69UiYmdoM/bHK5QoRgkTTaAwMg8Q7kmYUms3UmedP4gOKC49OWzAEkpCTjh46Ts/YCydLQZrrRwhGqmFaKu1LcdPbPoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik8UAGM3BYRbhm5bemz8P0kcWO7x9Xg9uLU3+FeV5rc=;
 b=hik9Z+YU5GiZNsw9OmU/zmVi3fvCvRnDuu2ZS/9tX7iJncIfCA+VjT3A3qL5IlXxz6lswjV+jgsdoTC4kUdk276ZbVXFbMAjMQtv6Lp8SWjlzlB9reTvkPQDU0zdVueBhJDUapJgH5D6juDuWO57mAzyN3Ap9Q+mbwwivi2GV8aFmc+T1GjkIIB7bATVyw1GiwtUKA7BJKnVaDb874lIxvNfTfFyHt/Re/3+4RlHO9JgYN/6FLnjhK1/DYYWDcT8vhWjcNh+fvuWf6W9RRJfg/C1lbU5MRuPPz9E0v1w3Z6t+bLB4iPwEsTFgSM+84D4N+lJPrl+Dgq9pY+iyhU5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <cip-dev@lists.cip-project.org>
Subject: Request for review
Thread-Topic: Request for review
Thread-Index: AdqReXLWuxh2CefnRPmS/nUttLvDRg==
Date: Thu, 18 Apr 2024 10:21:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103707207861000A78DD172C20E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB10116:EE_
x-ms-office365-filtering-correlation-id: 020f20fb-9ad3-41b0-e1cb-08dc5f914ccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 X28IWdVAvdPAg2qgBcenNo+a0t66IhTstgWPCKRRYssg5Va4h6gBOCM29FL86ImfmP+495YdIf7qYrQgyBg099Oph3oPivEVDa6QObeGd0N/wT31HyDytpCi0BjZUwXq1kEgnxhFZAndqmnz0X8fgMLMns0HOFEgrUWyB1YmLmAJ1fW4rrTqBNFgDmDdbtmMgkKjSOgT4sCnId9KuksEWrIgpiJjFMyjba29Go+2eLjbsWO+hXxBQtxDwZokwO2GxnLWdhv9SDXLWdJ5HuC6e3RxWdvXDmMVZL5mzithM7THOubM02j5F6ScGOh5DGtgq2Lr6jDFdDPuMyBdo5N0UUrzHg9UbT2FlkAshkkTC5c/9ZE6NmfigqJ96a2YSZVOHf+0gGZPnpkvuJLAWQ0DjABh6HXTQSEiWswmZMeFW1ONx0njll838sdAzGOD3Lni7R5bNo/1GE962ShRWCCHgZxjHPE3/R6z7GpAcFWjn/RWOmkDdAglh63Fk1rHSBlO6/L/s01WGaA24vT+OUubWUsgmxIqmHFOSA4HKWWQSiPjBn1PQdFMbBD8ylzYRCVNian7xfTNHvOKGMRxEnl4LY/IUq/w+kPXy1B1CCP1tlY94wUd+K51NXXyHOew8sApDtzTKNVAzbXKhy4EU+Er4XUtmc8OHStrY/QYy1Ersju2m0qFGRHVTWBbmU0HAIgW+KB2SBFaSGD7Lny2o1G1jwBMJD7UFpPco+YKpl56hHQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OVNlUEVybkVsL1pxNVJuNklGRUNWcVRiNUNROHNIdWJ1R0tJUnErQ1Za?=
 =?iso-2022-jp?B?Vk81Qm1QejZpS2VMcG9MNDA5a1RBQkpUTk5JSTZLYjM0MkJSQTFyVElj?=
 =?iso-2022-jp?B?YWZiOW9pVlUwVGc1QnZsODdhVWRWVWIwTG5WNWJkam5XVFl0WXVvbHpC?=
 =?iso-2022-jp?B?T3NTQVVmWUdrQStpY3FMVWVQU2JEdnRvdzNocXE1VDlkZWwzSDloN2Nh?=
 =?iso-2022-jp?B?Wm5RU0ppRDR6RmRNNHVMdlhML1dscFhxUkZaNkVVVzBVQkg4TjdrN3Fp?=
 =?iso-2022-jp?B?OG5ERUJZc2R1TTdjbU1NQmJHR1RVOHdoY0hLNStyMXBaU2MwV2djQzYw?=
 =?iso-2022-jp?B?NnRiUElCVGxWcUVoUCtKYkpDQVlPRy9PN1B4RVhyaVRCczB1Q3phMUJu?=
 =?iso-2022-jp?B?SmFBTnhYWjRTdGJSbkN1c0ZIcmpwSFo2enlrRWJjand3UGxxeCs1b2dM?=
 =?iso-2022-jp?B?UGFJSXFGVzlXYlM3eUlPbEJ6S2R3Ym5OYkdiSkVmMUg4azkyMk5HL2Ja?=
 =?iso-2022-jp?B?YTVYQ2V4SFF5ajhTZXlDSmdqYmtHWUhmRFZyaVpTN3FMZE1wNFdHS2J0?=
 =?iso-2022-jp?B?MVVBaWp6R3l3dy9tTFZBN1FZT04zYTRKVDBKeGJoYnZMM0FjeUxFQ241?=
 =?iso-2022-jp?B?SmJ0U2FVcHl6V2FkL29OaXpQYUx5cU5kQ1JZSmlLcTZEeFRwR0dVcDdk?=
 =?iso-2022-jp?B?Rzc3bm5xd3lsZkkyN09oNXBvUkxJN3BmNE8vdEhxT2NsVitZR3BGZ04w?=
 =?iso-2022-jp?B?OHNNV0JBTGY1TFJDRGNzWEpkZDhiTlNhZHlyVEZiWkpDbTcrbWxMazdJ?=
 =?iso-2022-jp?B?cGFOOGdzdFF6T2hLUWxSWVR1ZUg0bjhPdUpweXdRdWNCeEJDMjNvOUxy?=
 =?iso-2022-jp?B?OWp4TUE2WDVDR3lkVXJoeE9sNE5rNHRFVjRuOThwd2hadVNEV3UwelZi?=
 =?iso-2022-jp?B?TjJwRzRGUXhwNFNldWhFMFY5dUdmOXZMVzAxWWNoNGQ4YU41U3RMSTNV?=
 =?iso-2022-jp?B?OFJ2ajZyY3JRQkh0TitnQXFWQ1o3b3lJVCtiRnNwb0VnbHRmc2VqV25X?=
 =?iso-2022-jp?B?THRJYkZZajZZWVRieXQ1ZUpVS0hFWXRDOVV4azk3RzlrYXc4QVM1ZWE5?=
 =?iso-2022-jp?B?YWRFZHduK0NlVnlhNzM1bWthM2RwMjN3M2taVG5TRHpzWGkwU29BWEFJ?=
 =?iso-2022-jp?B?YThFVGpvU2pTc1FKbEVyMmt1ZFlROVdvdFdTSm13S2xQSk8yNkdTTVFt?=
 =?iso-2022-jp?B?QksyZjI0UjNraE01SVliSXlBazNYT0dyYUoxeW44VGt1VVdWbzZxY2h4?=
 =?iso-2022-jp?B?cVdYQjZMMTFZWGJUZDdWSUd5RlZXNm1meWt0M0tSZUNGNldiUWNhTFBE?=
 =?iso-2022-jp?B?dFcwMXVGajdiOVZFTmhRa3k4L3lVUHFPeU1oTVU3Nmt0ZmNjdmZYaTZy?=
 =?iso-2022-jp?B?V240UW5WZzh0bEVVZzFZRUM1ZlhqY0JMOTdWUHFDWEhlRko5K1ZJWkVk?=
 =?iso-2022-jp?B?akVkZnhFKzIzZUhJVFFLSXlMa1B5blVlNjdwM2l0U1dlcTcybWkyUjJk?=
 =?iso-2022-jp?B?a1ZWSFlmdG9RK0tyL0VVaHg5R3h1aUkvVW1FNUZsRTh1TVBTaVRPZFd1?=
 =?iso-2022-jp?B?OGpXbGxXMEF2Q3JxZ2RRTDZKb0tsMmlGM001cDFlZEJBekxveUY0Y0R0?=
 =?iso-2022-jp?B?RE9WNExXYmtnMTdaZUFPRC92MDhWZ3N1UnpZSmZsMEgwTTRoSnFFQS9R?=
 =?iso-2022-jp?B?ZmNKUUIvSUNMbzZ4VHF6T1lVem1CM0plYnFmcmNjMFhRVWttOTJqNG5k?=
 =?iso-2022-jp?B?VGdKOGlCVUM3b2JpdXB4cVZqaVAvdnpsZkNSS2lXRmJJNis3N0RRWmEx?=
 =?iso-2022-jp?B?NzhqTDQ5OVhJNHdrZkZZUE85TE1VL00yblJaTzhUQ0owMHRQVkR4bGxq?=
 =?iso-2022-jp?B?dU56Vk5sZEpGOHZTTEhnOWZkby80MTlFSjVJYXNwYjRmNHV6alFQVmMx?=
 =?iso-2022-jp?B?aEVESnlGd0ZwSUREQ1ltRUdkVlBpQjFBdFZGNWRXRWpxY2NXcXVQQzkx?=
 =?iso-2022-jp?B?Q3E2Uy9Tam1iOUtNcUs5TEEyR2hkYlVob1ZzODR4aXBoYmNLeC9YaXFW?=
 =?iso-2022-jp?B?QlpPTXBLU3dic3l5cGE1TVBMM3duaGxMRHdTZnE1c0ZweGtzM3NSWWFR?=
 =?iso-2022-jp?B?a0pSQm5JV0NOaFg5bGRmNXNtekJaNVI2c0xVUjR3TzNMUWZXdStIVkg1?=
 =?iso-2022-jp?B?MmZ0bGYvdVhJQTlwUnRNZmVEYzY4NmZUVkxsWDZsSjZZcXp1N1NDVEVO?=
 =?iso-2022-jp?B?MGJiWCtuaEtuWi83LzgvcjlQVmowcUpPbFE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103707207861000A78DD172C20E2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020f20fb-9ad3-41b0-e1cb-08dc5f914ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 10:21:24.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3Km5DUjlTgGMvk71hn7ynquRHXwE9xi0JsCcpPirKig2A8bFJOzPtf+wxrTkgoJR6UbfFMq4GjJ2rkDmWdnEZDRo4RXK1sc6hnP3cJDBEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Apr 2024 10:21:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15577

--_000_OS3PR01MB6103707207861000A78DD172C20E2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope you are doing well.

All the changes were made based on your review comments in this MR -> job_d=
efinitions: Add swupdate, secureboot and IEC job definitions (!1) * Merge r=
equests * cip-playground / cip-core-ci * GitLab<https://gitlab.com/cip-play=
ground/cip-core-ci/-/merge_requests/1> . Please review it.

We created another MR in which we are preparing the job definitions using f=
unctionality-based templates so that we do not have store all the definitio=
ns in the repository. -> Draft: Build test definitions from templates (!2) =
* Merge requests * cip-playground / cip-core-ci * GitLab<https://gitlab.com=
/cip-playground/cip-core-ci/-/merge_requests/2> . Please review this as wel=
l and provide your feedback.

Thanks and regards,
Sai Ashrith Sathujoda



--_000_OS3PR01MB6103707207861000A78DD172C20E2OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">All the changes were made based on your review comme=
nts in this MR -&gt;
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/1=
">job_definitions: Add swupdate, secureboot and IEC job definitions (!1) &m=
iddot; Merge requests &middot; cip-playground / cip-core-ci &middot; GitLab=
</a> . Please review it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We created another MR in which we are preparing the =
job definitions using functionality-based templates so that we do not have =
store all the definitions in the repository. -&gt;
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/2=
">Draft: Build test definitions from templates (!2) &middot; Merge requests=
 &middot; cip-playground / cip-core-ci &middot; GitLab</a> . Please review =
this as well and provide your feedback.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103707207861000A78DD172C20E2OS3PR01MB6103jpnp_--


