Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F5CC28B20
	for <webhook@archiver.kernel.org>; Fri, 28 Mar 2025 05:07:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.4801.1743138449266132932
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 22:07:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 52S57OX03802579; Fri, 28 Mar 2025 14:07:25 +0900
X-Iguazu-Qid: 2rWhBFYKJulPlxzjJD
X-Iguazu-QSIG: v=2; s=0; t=1743138444; q=2rWhBFYKJulPlxzjJD; m=TYW3+l3WNtUvcElETyej4XiA/SEouSa4mZ4Lgwosth4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 52S57MES1551065
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 14:07:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKWMd3pOndvvokg5gxVB9+H12AG/Np9pHf2xrr7Ohl7GE0bq3F8CNQ1GZOu7BlnKq8qBG9yE6kcnFIKLfTdQBppCqvzuwtgzT9JR/OHk3iJBwV+PqFrhTW83x3T6VAOJJimq084X0c0tW7VOG6RRjatvcRO6GXu6aL2dWe7s5XEoWIiDtUtK6PTxLK4Tu4CRRFQWqB3GoRVKo+YkqnEU1LfQrpAd1z33h5/VEwG/gjirBCbSp/HWCyBYSutDyXYzvnli+pTpvbaRN6rrxIelIyfy3BKat9fcBc4eTVieQFcFVXAnQ8XnM6OQ1nTjFUmJHo246oW4X3ACZs/UgM6Jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNqbJUDJ9hsYtJtGFOHX+ElIzsLZVk4o0Igd7mYN7ik=;
 b=OUF9qAjf+3X1amZ9EocvqrY/8h1huFTxD0gwTqVPrraddCB3+KbJSuapOSqqbkQA7Rx3YFuq+r8clUG8dJ3tAwHe6R0aCk0wkgiiYhu1dNgydiSN2zDz1fbfQ8xdOvcjlCDEAyY+qnEWSNJyl9Xtz48eWdlstn/0V1aQzrgWrexf/6W+lOqJhzS+MbIUMJy3fvQi4PB8AcFe7RMUSEUCYeOOEGRqNtEiAK+FNyGf5GP1YsxyymvbSu3aM8iKDIFWo/TXBnWTJvpv1x4tdSwjX/fu/sUScE2wIo9Zu4sQH2eDfN6+etVjsa79OiZzUKXtHasmpcGTnaJmgj7K1rOUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <submit@bugs.debian.org>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <jan.kiszka@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Bug report for aide
Thread-Topic: Bug report for aide
Thread-Index: AQHbn56XeE1yKSPynUiGaNtpIwUXIQ==
Date: Fri, 28 Mar 2025 05:07:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB14838867E83A31E2CAD83A275C2A02@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TYWPR01MB9631:EE_
x-ms-office365-filtering-correlation-id: 887aadc5-1aa8-44d8-262c-08dd6db66b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WFJ1WUlpRFdUN0p1U25McGJZQ09aMHVmeCt5R1hFNldBVTNzbW5HNkRK?=
 =?iso-2022-jp?B?NWlxQlFGMi9lcTB5b2tLZjZWS1R1NVlrZHcvZzN3Um80NFFxTm9iWnov?=
 =?iso-2022-jp?B?dnpCL1NCOE5CbEpmQ0VnbGs4bFBXWDY4RE8yNE1kZ2ZOMENnUXZIb0Rm?=
 =?iso-2022-jp?B?ZTVQbGRoT1hNREFNQjVJOXRhckNwNHR1SUd1NFVJdyt6d3M3N0NJRFVp?=
 =?iso-2022-jp?B?RWpsanh0VUo1NFhYdDgwcitMdUZZN21oK2FSSzdHcGN5UmowVTYvanFz?=
 =?iso-2022-jp?B?REh6b0dadFRseC9MVHJYVHhpdFVkd0I5UDZCMWFIZkF2dlZGem85dVA4?=
 =?iso-2022-jp?B?S1lMbC9QOHA5NlN5WnhhMFlsbU5reEl1bCtrbjA0bVFtN3d5TlFDNTNs?=
 =?iso-2022-jp?B?RlJZanB5M3RiZ0orQUJSa2dvRldwZnYycFB1RUlqbHVEbXlUZnVCMm9N?=
 =?iso-2022-jp?B?OG41MEl2UURFVjZqRVQ3bnk4S1JmTmZkVURvM29jbno0MVJKNFp6Z2di?=
 =?iso-2022-jp?B?UlFKM0ZvWlhJOVZET0krM01Lem5TV0tsM245KzBhSFJhSWsyTXp4eTJv?=
 =?iso-2022-jp?B?Z1BXZXZ1ZGVkZHZTdVRpNmxVbFdtTm9zbnZqckM4QXVZd3Q4Vlcxd2dL?=
 =?iso-2022-jp?B?cWZ6SXFCaFdOWjVObENHcnJ4QmwxMXlSaWtMaENnTmhteUt5VzZPUDZh?=
 =?iso-2022-jp?B?bmtDempZQTdUd0pDNldXRG9Xb0d6ZkE1NGU1VTArQ1hxUkxNdHk1dXpJ?=
 =?iso-2022-jp?B?dFRzSWwxaXYxeEZHbmMzMHIrZzQ0QkpIV2FZUXFHVHVGd2I1NDh6bDNj?=
 =?iso-2022-jp?B?NWpBVkZNbExVNDdDZnd3SzljUS85N2J0cldpUVdzMTNRU0swOHlwTVRL?=
 =?iso-2022-jp?B?NjV6MXR2emZrZ2FmUEpOcHREOEh2OWg4SzFyTXlwcEROQ0UzQlZzelNy?=
 =?iso-2022-jp?B?VzBsU0xTYlZqT3ZocXFMSE5BcEdJQkRTUFV6YjVtdFhSbktWQjJEZ1BS?=
 =?iso-2022-jp?B?MjVoTCtlOWFZVTVFWUU4TlFxZVV5blR4VHRZaGhqZHZpTnFvZWFmTjNZ?=
 =?iso-2022-jp?B?Y2N1WUttY1Qxa0U0b3BibmhuaGtJbmIyayt6WTRKQjJZT2JvMDVQYjNR?=
 =?iso-2022-jp?B?bG9hYzdyV1o0V2VrdjZrNVdWKzZvbnJqVWFwRXNyOVA2Rnd0RGpRU3do?=
 =?iso-2022-jp?B?L0FkRDdTNXFqcnZzd1VtSkJFTUpEcXNhamFsNDNtWjlZRjZ6YjVweFdI?=
 =?iso-2022-jp?B?VWloOHpUanlWQm5IbzdRSzZBdy95eWc4d1VkSzFNWFRWRFhrTmMxOFdw?=
 =?iso-2022-jp?B?Y3V3anlGVjlkempOK2tQNW1HWXduNEc5RVdFQUgrY1FTV3EwL1V0NTJ3?=
 =?iso-2022-jp?B?NlByUVY0UFIyOVlVanBITG5hdG1OUzFqa2JqaUd1WFJhMVpxSGZOSE9O?=
 =?iso-2022-jp?B?MTVtN200NG44bURSVkdiUHU5c3M3WU9TVmp0ZHdVVU1jQnUzU0diVzBM?=
 =?iso-2022-jp?B?MjFyRjZmZzFnRTRhcklVWXVFWHE3aXZzMUhoUEplNk1US2NlMFpJay9E?=
 =?iso-2022-jp?B?QUNLeWo5VFJ1dEY1SGlFYTg1V3RGU3k1UlliMWFsSVF0TzVXL2lzVzYr?=
 =?iso-2022-jp?B?cjZKd2RFMGNvSFpSYkthSXZpOHpUMzlmZzQ0M3VUeSs4ZVAxVjJxZ1J1?=
 =?iso-2022-jp?B?a3gzMDdnZXJoRGd4T3AreTVScXRsdk11amNCRUtHOVZLd0xLYUlON3E5?=
 =?iso-2022-jp?B?LzU5ZTI5QXpzanBsUE14eVlnT2dEWjlWbHR3NzhLVDFONlVjemtwYUY3?=
 =?iso-2022-jp?B?WUl5QkZHcjVrV3paYVE1RVlWUGFQdVpKNDFaaDhONmVENVZQMWpFWGpk?=
 =?iso-2022-jp?B?UkVzdVpCeTBhY0dwbTBRMzZoZGlvQzlkWTlnYWM3WXBHdEdYN3h1ZGI0?=
 =?iso-2022-jp?B?aVlReHNTcTdQekNmeTl4WUZHZ2w1MGlVU2lqVTMzbmlkandOZ1M4eThT?=
 =?iso-2022-jp?B?b2dwdkFlYTB1czNkUWg1cUdha2lXVE1xbFZrYWRJREIzSE56TzlHSjNy?=
 =?iso-2022-jp?B?ZFJ4OTNRZXVVaWgzVmJiWDRaYTVKMkU0TGtKYjBPUk9iS2JNYUFNZUNY?=
 =?iso-2022-jp?B?RFc=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NWIzQVV2N0trcHpETTNIZHZrelllMlkyNVA5ZmozdjFWbHE2VktOSmRz?=
 =?iso-2022-jp?B?aVdQMzdvUFlWUjFCM3c1Zjg0Uk40eG5GUndXOFYrT09HZjVEd3BjQnlH?=
 =?iso-2022-jp?B?MjhiakhxVWxjVnpvOFFNRGVvVHBxSStScXVxa2wxZUhZcFVJcTNIRm1J?=
 =?iso-2022-jp?B?cFNUa3VmdW9jQ2dEdGNSU2ZZSTZqdnBxcldWN0NqdzJ0a1Vic0lnSHJB?=
 =?iso-2022-jp?B?eVFCL2EreHBZSzFGWFEveWZGVU5mb25pTzVXeDFmelAyTHRnOWNOZS9P?=
 =?iso-2022-jp?B?VkEwa0g3bldaaWF1a1U4QnEvcFg3Tjk3TEtiR05yZkt6MDNQMEFRU0pH?=
 =?iso-2022-jp?B?NVZaTm8wZmhWT2QwMG5sN3J2N0xOaHJsa1NSZjBEYWdWdi9IbXNRWkwv?=
 =?iso-2022-jp?B?YjMzYW05Z0g5MVA0K3hRc3J0T09lblo3N3VoUU5lR09mMERCWUhzVTJW?=
 =?iso-2022-jp?B?MmppN1VZUmRXaDhKcmZjZEhPMWdxMzcyWlN4b0NoVWZYMFJqb1BzZDU1?=
 =?iso-2022-jp?B?V1dBU1VVb05nZzZCYTRHR3M2b2xtV2lVajlVSldYUExHSnE0bkRENkJv?=
 =?iso-2022-jp?B?NzJiTE9ETW1ldGhtdGp5QWROaUdWb0RaMmRQVldoWVpyRS9KeS9YS0x2?=
 =?iso-2022-jp?B?T3orVTQ3WFpOZ0tNUzRqdEVpRFpxNERENmhLV1dHQ1NjTVV1eVZrVFN0?=
 =?iso-2022-jp?B?VFIzMGZ5cnhEZWljVnhwT3hZN04rVkNXY0JQemQzUVRlQTk0REM3YnBp?=
 =?iso-2022-jp?B?d1FjU2dxMkNaZFJDd1hoTXhnTXlzVmVkTVUySTRTSUo1UVpMemRyWWhl?=
 =?iso-2022-jp?B?RWZKdlEycldvcnNIMjM2d24yNEdndkRHUlZpeXpBUm8xQ0N2SzN4ZVlS?=
 =?iso-2022-jp?B?eHZNbVpheGxpVDVGN2NSQWtLSWI5SWpKSVVWamxlYU5pamZlRmxXMFds?=
 =?iso-2022-jp?B?a1V4K1FPY0xIaW5heWNvcnhIdldITHNPYUFDaHJ6THhsYnpZL3RWYWcx?=
 =?iso-2022-jp?B?Z0J2QjIvOVA1b2VPRDROeHNvcHhTd0d2dkQvNGFnSDFpSDFpblR5RndZ?=
 =?iso-2022-jp?B?YTROMGREcnI1UFRPMnFLRXdEZmNicWxWcFl1eVNqdGVqVnVCYWxnOHJF?=
 =?iso-2022-jp?B?dVYwOGh2YjEzbEVkcEtmWXp5Z0krU0c0MlJ5c25zZVhiYzN1Nm8zTTJv?=
 =?iso-2022-jp?B?QmJMb3VYSDA2QUtOVk9hQ0hFUWtFN0lOY1Axa3Fha1FTekhFemJKYWZs?=
 =?iso-2022-jp?B?citSVEJ2RThFSlJPK1QyRmVBY1BtUWxiNVA4Z2NRMG03dWxRT3RwM0xB?=
 =?iso-2022-jp?B?bHpLTXFCVkxZSFE2VU0yd2tmTDN4YkRYYXRoN2tOcS9NM3ZXdGJWWUhj?=
 =?iso-2022-jp?B?RzVqSXl2Szh4VlNtOXVjWHJrMWNyVGZPT3laUHJhY1I4TWQ2N0tlTHZE?=
 =?iso-2022-jp?B?aDVuN0hoVEZMYXowTS9JWE9nclNLSHBmRzVhTDBrTmlwTHljOGg3dFNS?=
 =?iso-2022-jp?B?TTYxREtLc2RRazdHdzREUnJTWWNsMTRVdEM4RDdXV3E3MC9KUHNEdk01?=
 =?iso-2022-jp?B?Q3FVYzZPY2MwVm1qNXBjZ255bm8zc2ZZRjFKSkRIRHFPMENsLzRhdnBT?=
 =?iso-2022-jp?B?anVXYVNBVjhoZ0YrWExtUElzKzNaNlJNdlp1cmJ6THc0Nmd5TERodHZv?=
 =?iso-2022-jp?B?Y3RXQ3drQXcxYmdNaUJTc2IwSW4vYUJlK3lOeE9XL2gwVy9hZUFFbWpW?=
 =?iso-2022-jp?B?VkJUdGg1N3ZWZ2x3ZWlCQmFXTWMzZnRLR1hETVRoK21KNDdOMlBZN0di?=
 =?iso-2022-jp?B?bi92RXE5SXczSGJ1bUpVVHh2OU1wRW5JL2RjdEhlR05zZnZLSmtSS294?=
 =?iso-2022-jp?B?ZWZtdk5QaXlLUHA1emxySEFZMWh1VFR5b2lDbHNBWDBhVTNOTHR4TWdy?=
 =?iso-2022-jp?B?cS9GaEdja0dtbzh3dU91NDVwMWlOQUo3RDk1ZnhMTEFxYW1uVUh3dzE0?=
 =?iso-2022-jp?B?NEdZRjJ4TTFickFZRHplQVR5aW5odTR2Y0QyYUNGQUdlb3lNTkJaTEpK?=
 =?iso-2022-jp?B?K0o5UlNHRzhaaFRxOHFNbkhzNkQ4Qmh4NU1xbENZaGdXRXRSSlV1NGxw?=
 =?iso-2022-jp?B?YUtTQnBZMHdwREJIcVZqN2pvV0RlK3RBV2RsaXhiSUZIMTV0SUFWc2tv?=
 =?iso-2022-jp?B?MzcwUkxJYjhUZXg3WWVDSXJlN21WclBLRFB5SVlBQ3JIWXA2OUhFZVhs?=
 =?iso-2022-jp?B?TStNeUQvV0NQKzVvWFJrUE1mbnNROGxsc3l6QzZremtiNFdpTjJwYXFB?=
 =?iso-2022-jp?B?LzJ1V2drOXVBdTVZNlphR2lUOFdlUk1ZaUE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB14838867E83A31E2CAD83A275C2A02OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887aadc5-1aa8-44d8-262c-08dd6db66b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 05:07:20.4368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNUvKhLhXpEb/9ePPAo+0/D3kpyP3whcSickXNJiRAHAjvC+iUxdvnR/yzN68hWvVGsGEEG9OT9V34nT7AnQ2yzdtJCd1P0kjWEOS7XQdfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9631
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Mar 2025 05:07:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18384

--_000_OSCPR01MB14838867E83A31E2CAD83A275C2A02OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Package: aide
Version: 0.18.3-1+deb12u3
Severity: normal

Hello maintainers,

In a Debian bookworm based OS which is booted in QEMU without any dedicated=
 home partition.

The /home partition is moved under /var and is symlinked to /var/home.

I have experimented the following 2 scenarios to verify aide's integrity ch=
eck after adding "report_url=3Dsyslog" to aide.conf

Scenario A:


  1.  Created a sample file under /home
  2.
Added that sample file to aide configuration file like below:
     *
#echo "$SAMPLE_FILE  VarFile" >> /etc/aide/aide.conf
  3.  Created aide database file
  4.  Explicitly modified the sample file.
  5.  Ran aide check and found that aide is unable to report integrity fail=
ures to syslogs.


Scenario B:


  1.  Repeated Scenario A, but the only difference is in this scenario samp=
le file is created under /var/home instead of /home.
  2.  In this case, after modifying the file and running aide check, aide i=
s able to report the integrity failures to syslogs.


Is this behaviour expected ?


Thanks and regards,
Sai Ashrith


--_000_OSCPR01MB14838867E83A31E2CAD83A275C2A02OSCPR01MB14838jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Package: aide</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Version: 0.18.3-1+deb12u3</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Severity: normal</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Hello maintainers,</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
In a Debian bookworm based OS which is booted in QEMU without any dedicated=
 home partition.</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
The /home partition is moved under /var and is symlinked to /var/home.</div=
>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
I have experimented the following 2 scenarios to verify aide's integrity ch=
eck after adding &quot;report_url=3Dsyslog&quot; to aide.conf</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Scenario A:</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<ol start=3D"1" style=3D"direction: ltr; margin-top: 0in; margin-bottom: 0i=
n;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
Created a sample file under /home</li><li style=3D"font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div>Added that sample file to aide configuration file like below:</div>
</li><ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&qu=
ot;:true}" style=3D"direction: ltr; margin-top: 0in; margin-bottom: 0in; li=
st-style-type: lower-alpha;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); displa=
y: block;">
<div class=3D"elementToProof"><b>#echo &quot;$SAMPLE_FILE&nbsp; VarFile&quo=
t; &gt;&gt; /etc/aide/aide.conf</b></div>
</li></ol>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
Created aide database file</li><li style=3D"font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
Explicitly modified the sample file.</li><li style=3D"font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
Ran aide check and found that aide is unable to report integrity failures t=
o syslogs.</li></ol>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Scenario B:</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<ol start=3D"1" style=3D"direction: ltr; margin-top: 0in; margin-bottom: 0i=
n;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
Repeated Scenario A, but the only difference is in this scenario sample fil=
e is created under /var/home instead of /home.</li><li style=3D"font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom=
: 0px;">
In this case, after modifying the file and running aide check, aide is able=
 to report the integrity failures to syslogs.</li></ol>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Is this behaviour expected ?</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_OSCPR01MB14838867E83A31E2CAD83A275C2A02OSCPR01MB14838jp_--


