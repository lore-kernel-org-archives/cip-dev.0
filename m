Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B998C3064D
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 16:39:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.32314.1719419975171916165
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 09:39:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 45QGdWRj3030456; Thu, 27 Jun 2024 01:39:32 +0900
X-Iguazu-Qid: 2yAatxQ7oLC2SDU88G
X-Iguazu-QSIG: v=2; s=0; t=1719419972; q=2yAatxQ7oLC2SDU88G; m=LBufw9h76lz/+Xa9dtZyF/s8QbI0/eE7wNKovwgWXD0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 45QGdVah3994619
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 01:39:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfkcx7ezvdaKqcPw37+3FGEDCMGKQwY0oNLHPWAht9RY1baJ2tLxPu/3t8zWzanqZrvWtoACV7Z5VLl/Z5fnLdANuZFdzRfy1Hr1uLKTSZWJla9IWaHirGoasyon9uxedOE8OfMRnf00Gfrg5xLOhmdA//z5HXYTdhkwvOYEP6JmDtJWt6u6Uej/Zv44Rjv6Y/VemkpupC15CYV+yPh2u7X7saGQg10IZ0wZ1IjkFHTYMB2cVzHHAgmxRJrO9CtnSq4hU/omChiX+pZmCggYbNlYAXUtVFAd4xi9e9N1J9khd5hrBUdw/yOyVK9Ud/hD2jn30ECwhGc2NNS4h2MEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMx9Og3wU9PvUkBtYDguIrIQSj9en/yDoSQmbANsHRk=;
 b=XsXadOUqo0KMoS9XcCxyqZTAMYiRGlVQGhHB209sO+Q7n5WAro6tzn8jRaqwkI/4cTELBcoZMuD3wdXdlwui1jWQiDnTPAAvdiXz3VUeXV9rbTN010YgzHJxnWksz1LDo0plrZ6GNjMSt+aN+rK4/eYXoug8BW+1qFVPIXvDA7x/26eVxyYO2Y4606buohur9C/B2lypDBgkPbaFPYFeQVudggwYzNghxnyxLp8j79d3RnQIYLqxClAeM77cS82elRs+Lf6be+T3NlojXCavsVIXjMn25E4I70HClGhzClYLO+1sD0Wl6GfUmTjBcZrvkkT7yvF+1qfu52akTD4YFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Generation of test reports from CIP SQUAD for CIP Kernel and CIP Core
Thread-Topic: Generation of test reports from CIP SQUAD for CIP Kernel and CIP
 Core
Thread-Index: AdrH5VmRUEDgCPekRs62LtuK4XbxNA==
Date: Wed, 26 Jun 2024 16:39:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103D9F8FA680A7378453867C2D62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYWPR01MB9920:EE_
x-ms-office365-filtering-correlation-id: e5d3bd79-b7f9-4a00-dafc-08dc95fe8be0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|376012|366014|1800799022|38070700016;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?d2hkakxiTG50TzRpdmRBK3pTRko3NWlvVzc0WlUyNmNrYTVEWm5ObVBs?=
 =?iso-2022-jp?B?ZC9tQVoxMFpOQTJXcERseitHN0dxMW8wU1JrSmhEK0tSN3ozcURacndC?=
 =?iso-2022-jp?B?VXZnQ21Tak1kdktCMjl4ZVBacjE2dXBKUDF0Si9MaWZBUzFYZEUyREpU?=
 =?iso-2022-jp?B?ZDNLdTExeFIzY1VLK3YyWDQvV1hqb01rR0tCMy9aVExtR3laMndod0hB?=
 =?iso-2022-jp?B?SlR1NGpaZjlmaC9kVGMwTzN5UGpjUkFNd2pnRzNSRmozM1dIL1VpNUJC?=
 =?iso-2022-jp?B?ZG9qUUtoeG5KT3l5TUxYNXN1N2VXYWExT0hTcTQwMjlFMGlwZ3psYnkx?=
 =?iso-2022-jp?B?UEhobGwzTGxSbHJEWmhSUnRQeGZHaXpqVjA0djJVVUY1MkNUcldtUE9F?=
 =?iso-2022-jp?B?NkxONVdlL1VOKzlZcktRdmZ3TEt6Z2FXSEx1d2pFR2IxY3oxS3lHWldQ?=
 =?iso-2022-jp?B?RlYvOG15VWY4Rm54Y0R0Q3hlUjU3aXdDSFRGanlPSkJQK1RyNS91Ukxv?=
 =?iso-2022-jp?B?My9PcVByWTh1djJlZjl2cHdodkZIaDZlNHBibm1nYkhEaUVNQlRiVDVP?=
 =?iso-2022-jp?B?QUdSL3o3UGxwWFpEeUdjS3U1WEFDWW5XVFFpNFNod2paOWk3Wmg1Y2Ni?=
 =?iso-2022-jp?B?NlEvUkxsMVlrc29JRWJvdGVDcjY1NTdRZVNLWWxJbFJlVTVCOEVtbXY4?=
 =?iso-2022-jp?B?cE1HaFF3NUNsR28weEVYYStET3Jha2dxcVFiT29LcFMwWWJ3YUZ3UGVl?=
 =?iso-2022-jp?B?UGM3ODhXeGZQZmYyUVFrSWN3OTRja3JianU0OU9JVkhVbVUrVmpuTjg5?=
 =?iso-2022-jp?B?emEwZmFYL2l5WU5CTXRrcGI2UjBkV3k2cTdMRWFZSDhlM2lKNndRYS9O?=
 =?iso-2022-jp?B?V0kva2FCelptNVR3L0RjWmhoaERQUHFxL09ZTHZkS3pBaEFnTlBGWkpX?=
 =?iso-2022-jp?B?NjlBK0ZDeFl3VnNDMHV3VVlDa2hGWGpuZklBTVROWFVKMEg5UkR1S3Q5?=
 =?iso-2022-jp?B?SzVud2ZkL2JrQTNqZGxyMXh3MWMza0MrcFBSZDVndFJNNklMR0FZMis3?=
 =?iso-2022-jp?B?SzYzRy85T0dqUW5JWTBXUHV0dFJ1VXhJcHlESWladEZGK2ZERUlXNTFQ?=
 =?iso-2022-jp?B?TDJGZElyMFp0azJCejRXalVROXdtTCtWV0Z6TWY0VU11NUNkYU43UzNQ?=
 =?iso-2022-jp?B?eVg1N0xxemNKckg4RFJRU25jWGhjWUlFUU9HU2xzTHpSa29RdEsrc0t2?=
 =?iso-2022-jp?B?TWRkam9hOUJtMEN1c3cxL3FTS2RSZVNhelIzRWRiUjFFL2FCdnZ3bkV3?=
 =?iso-2022-jp?B?RWlSYStGSEJTek4ySzRmaXdJREdTMHlEMFZ1MzVhRHVyUi9RS0NENW1K?=
 =?iso-2022-jp?B?Q0NmNzAzbU5tVXFVVVVyOGNibHlCL1JPYWhhNkk0eDU5UXMyb2MrU0F1?=
 =?iso-2022-jp?B?eHRnNlZvSFFiSnV3K2tGSHBaNU1aWHVKdHlzL01QY2tNaTdVUjJjQVB6?=
 =?iso-2022-jp?B?azZtVTN6dlBiWUFVWStQOXk3NDdEMmtvRlhROHlhanlrcHVINzMxNjA5?=
 =?iso-2022-jp?B?V0FmMDJGcmk3cnRrSTNMOWVNZTRnSm9JanFrOXI4alpPZFJCSmNhdmY5?=
 =?iso-2022-jp?B?a1c3Z0xnUnd3bGw5L3hPVm9vRTl2dkVTb1lSK1JWN0QrUmN2NjFYNGI5?=
 =?iso-2022-jp?B?REFxV1NCR0FoRDc5aE9BQy83TkNZbWxvdDRlWkExUFUvRnRQbGRLNHpl?=
 =?iso-2022-jp?B?aVY3Ym0zc3VPZ3d2eW1UVnI5REk4aXYybGFUbkFnYlBmSG02a3J1eG5s?=
 =?iso-2022-jp?B?cEIrbmx0aWZFMWVEL0Qvc2NEVzFqWE8wbzFQMUlwREVJbGduYThmU2d6?=
 =?iso-2022-jp?B?bFllbUQ3M1k1cDNGTGJkOGpOZXNVaEpoWUFBSHQ1c3B2a0kzSDBpVnhF?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OW4vaFBndzNXS1JGTWt0TWJROER2VWw3UVU3dktGdnhmMUJEUEFFVUVH?=
 =?iso-2022-jp?B?eTFPVjVtWFgvMzlOd1ZTbXlMc0UzQWMrVVBTYlNUMXc3V2tibEJRU1hQ?=
 =?iso-2022-jp?B?cDZud1oycHpONHB1N0NXb05ndFE5UDRVU1NPenBveElYS2p2MXpvd3lV?=
 =?iso-2022-jp?B?VUozRDQ5bTZRRDNNSkcvZnBLM3VzaWN3L05nT2JPM09OSWtQKzdEcndK?=
 =?iso-2022-jp?B?QXZCa3Z1cDB0a3dIMk1kUm5oNEo2cElUbFByOWdTUUpLNThQWWI1TVFM?=
 =?iso-2022-jp?B?YXJBSU96UmNweXZxRVlRd2srL3hqTlV1L3dvYnd0SzEzeVlpamdJb01i?=
 =?iso-2022-jp?B?aUs5ZjNnZHdGSEd4ODM4SU40TWcyN1JIWVR0Q3luamM4MFc2LzJGVWZh?=
 =?iso-2022-jp?B?UTFDb0RickdoTXFvSHhLZStEMmtTMEtUcTJEWUt0OTdiVnJXKzBjQ3Ez?=
 =?iso-2022-jp?B?bE51R0g3aGN3czFqdUdVNkc5WE9xSy82ZEN4NlEyZGlGYkdRQlg1U25K?=
 =?iso-2022-jp?B?eGc1REZoOENBLzVORk5RRlJhZE5kRDNDU1dRMzhwU01NdlZJYlBWdWRO?=
 =?iso-2022-jp?B?NEZvNHJrY3BQdXhxcmdtNFlPMkhSeFVVbGRRV3hxRktNOWc5V2JWRmMz?=
 =?iso-2022-jp?B?L1VlandaYS9VRnBPSEJPOHdlY3ZxYXkrMHBwcVozc3VvbDZidU0xMmdL?=
 =?iso-2022-jp?B?Um1saUUwSUY2bTlSUkVIeWNabGdocFdLUDFhbGZDeXNFQmdpNk9NNHJo?=
 =?iso-2022-jp?B?elpZcnF3dnc1SG81ckwwdlZUR01FeS9qK1NibXh5MVE3TERCUFIwODVr?=
 =?iso-2022-jp?B?K3ZDSENXdWNqQlZoLzZCZG5zd012OEQrTm50dFJubm04am1ZSEFtYXUy?=
 =?iso-2022-jp?B?ZE45K0luWVRRbU40OTBEWUVQTFlnSlRWY2NybHR3K2tnVVZaOVJtMlhN?=
 =?iso-2022-jp?B?T1lFUVFQWVIzUXBDa01Ud3NOaTlWdEVzcDhUaHRTTjVXaUIyRTY5Sk9k?=
 =?iso-2022-jp?B?cjBMREJZbTBReklDbGh1OWNoeVNhQ0RBZWR0NElTcDNoYUt3anZIRUN6?=
 =?iso-2022-jp?B?ZDVHVmpRQlV3bmhxK01xT2Y0em0rcVA2QzgwdVB4WUwwSTJhOHhQMGor?=
 =?iso-2022-jp?B?TktlY0d5WFhnNExWdVl4RDhETzUveW1ScldBKzhqVmx2K0hnR3NFT0Zj?=
 =?iso-2022-jp?B?N1kwd3NzaHUyRi9KdGNlVGdrUE42MHk2Q2JSbHRiSWJhUUhwV3BlcFNi?=
 =?iso-2022-jp?B?elJiRTFvRTJCTXpQckNWMnpGSnAvWmdiQjhKSW42ZVpQT2xNZThwdmwr?=
 =?iso-2022-jp?B?VjRMcXgzK0xEL2JvZGw5L0YvOU85WVlKM2FlRDNiTEFnUi9oeC9JZDRm?=
 =?iso-2022-jp?B?MEJnSWQvSmFpT0lTaUphaXNDWTIzY2VXNnZjNzZnTzZ5WEhYc1RSRjRr?=
 =?iso-2022-jp?B?bHR4ZFpQYUMvanl3Um04b1BQaDErYUZ3WnR5TjllNmtPblpTK1BGdGxk?=
 =?iso-2022-jp?B?ZitndE96TGZuWExkTjVJbTByaXNOZlpuUXhpTTR0bHh2cytXUExjeFU2?=
 =?iso-2022-jp?B?dWFCWjh6Ny9VR09NQm4vcFBCTkZYd0dVL2N2SUp2QStWT0dkVlVJeHhG?=
 =?iso-2022-jp?B?KzB4ZzdtcU95QU1HdmtNSk8yeWdUSVp5K2xYNThPcGxBS3FJYWRuTlFn?=
 =?iso-2022-jp?B?djFYblJOZ1FGWWdWTGcwOHBPVnBSZU9CY1RjZ3VWWHkzYzJYYXZ4VnAv?=
 =?iso-2022-jp?B?WVJ3cmY3VkR5TnUrUnc2bVE5WUpyRmlGa2RoN3FzZ3NoQTJMbFNkNHRv?=
 =?iso-2022-jp?B?RmxYOEJpZ0E1a3JjSUlZb25ZSkFEWWtRWEhYSmU0YnIveGtsL3NNRzY5?=
 =?iso-2022-jp?B?dFRtYjAvc3BEakp5WkRxcFN2Q3V1Q1hvVUozUjQweTNCYXVaZ0x2TGtn?=
 =?iso-2022-jp?B?bWVSa2dDWlJ3Mk55OGFyREpQZ1pVSGEwUklxV0lmRzFqWkhWeWw3Smds?=
 =?iso-2022-jp?B?QlBQYUE4ckdDWC9ZRnBoWTg1TXJZcmoyNC9TcThSSUlnbGErSTQzcU5y?=
 =?iso-2022-jp?B?WlVTd21vbXNxS3lWRk02Um05VGRpQ2NuRkdCSkRnUGhVaGJkWmVrdjF0?=
 =?iso-2022-jp?B?eTdhaUhQVlZLU2FkWXgwMU5XY3RCaVlDaUp0dXRBS3RhZ3dqL2I3SVBW?=
 =?iso-2022-jp?B?NEg3VjdvZ1dzUTBYUlhOa2hCS1cxTzR0UzltMUZ5RE5JOWp6eUpUVHc0?=
 =?iso-2022-jp?B?WU1Xdk8wWmM1ekg3V3pwaFNPc1VwYTRqMDBUSFFkeWcyemhZOTBqbHQw?=
 =?iso-2022-jp?B?bHNpcmdtbEl4eVZMb0c5blpGRk0zbjNQR0E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103D9F8FA680A7378453867C2D62OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d3bd79-b7f9-4a00-dafc-08dc95fe8be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 16:39:28.0334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3STAEWE1WK2ZAuA7d+zjLSbj/mH6vjUHhiLdo2ZAvu0xqIWP+ow3x+h9vUeXOrswc1anZQgQkqZLjKQ+vRTxaMDoUnS12MbD+RhRwZvtNXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9920
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 16:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16333

--_000_OS3PR01MB6103D9F8FA680A7378453867C2D62OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Hope you are doing well.

Currently I am working on generating PDF reports from the already generated=
 .html reports in this project https://gitlab.com/cip-playground/squad-hack=
ing/cip-release-reports. Based on suggestions provided by Sietze, I am tryi=
ng to open all the data hidden in details tag in the html report after they=
 are generated and then generate the PDF reports using python-pdfkit. But t=
here are many links in the html report which re-direct to the results prese=
nt in SQUAD platform. I believe these results present in SQUAD have an expi=
ry date, right ? Is it possible to configure SQUAD backend to store selecte=
d results without getting erased after certain time.

It is not favorable if the links present in the finally generated PDF repor=
ts sent for assessment stop working after a certain period as the date is e=
rased from SQUAD. Can we do anything to handle this issue ?

Since Sietze moved out of CIP project, with whom shall I discuss from testi=
ng work group if I need some help while generating PDF reports in https://g=
itlab.com/cip-playground/squad-hacking/cip-release-reports ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)



--_000_OS3PR01MB6103D9F8FA680A7378453867C2D62OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Currently I am working on generating PDF reports fro=
m the already generated .html reports in this project
<a href=3D"https://gitlab.com/cip-playground/squad-hacking/cip-release-repo=
rts">https://gitlab.com/cip-playground/squad-hacking/cip-release-reports</a=
>. Based on suggestions provided by Sietze, I am trying to open all the dat=
a hidden in
<b>details </b>tag in the html report after they are generated and then gen=
erate the PDF reports using
<b>python-pdfkit</b>. But there are many links in the html report which re-=
direct to the results present in SQUAD platform. I believe these results pr=
esent in SQUAD have an expiry date, right ? Is it possible to configure SQU=
AD backend to store selected results
 without getting erased after certain time.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It is not favorable if the links present in the fina=
lly generated PDF reports sent for assessment stop working after a certain =
period as the date is erased from SQUAD. Can we do anything to handle this =
issue ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Since Sietze moved out of CIP project, with whom sha=
ll I discuss from testing work group if I need some help while generating P=
DF reports in
<a href=3D"https://gitlab.com/cip-playground/squad-hacking/cip-release-repo=
rts">https://gitlab.com/cip-playground/squad-hacking/cip-release-reports</a=
> ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103D9F8FA680A7378453867C2D62OS3PR01MB6103jpnp_--


