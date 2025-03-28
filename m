Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BC0C28B20
	for <webhook@archiver.kernel.org>; Fri, 28 Mar 2025 07:09:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.5907.1743145775389576589
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Mar 2025 00:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 52S79U9j1160680; Fri, 28 Mar 2025 16:09:30 +0900
X-Iguazu-Qid: 2rWhBFYKJuuLjLZ8rp
X-Iguazu-QSIG: v=2; s=0; t=1743145770; q=2rWhBFYKJuuLjLZ8rp; m=sSJLmmf0ouxD/DQzbrO3KBfezY2daP3HQtCLYeoNU70=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 52S79TGQ2557896
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 16:09:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URpjkR2amsB+2P5M8rPVPh9SpQMdsdirh/dTjrNVouBYjaeMC8lRS6Bk8XB623pAvlaeXZQAnEq3YWkuQG57Fwv3DIxbgcI43+6qE7yy+MDs1Y5OiosDzEYrHnh5yIisagPZQiZFUuRSXXigP34bxa8Q1sbq8hWGRS7UKMCyUBjTYfZ/QJSA+9YVQQrafXwBIpxSIWaAXPzOiIKVbh6COUcihrCy9ZVexB52YUE9P/wU/Mb9oBp63/4teg5hmMzXboIamWVSOxdJR4wmKcNv+BamD1jOMweVCN3r7ue2LNrp/kawMf9CrvG9cfCS3zpfpQVusnozpmjUcxOxiejsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaqF+M44xeidgRqH+CBmZOqJSydXBVUGnFT96Scgnsw=;
 b=DJNBL4RifX1IgK//WA3yR+1plIz6Wl1M/8Jc3k2CUW0/8v5+xvreZ3ipRSZlh+oboOBpWkS9wfl0z6ukBRrBrk1rijAMIrwXFmCRVVHLeo9dIc6He1DfiQ1Auq+lTcWS1kHJj68YP6H1zUb/gX7BPrb1jOomGnCXKYaKg9Kub0ZY1bBOrsu/tKt//hYF2G6enV8FU6aIvbrq0ZT6FbhdCqTXAx1RP1eshZ+iC055L7q+AqpEutZevJCl2g3wRDdMKAoMhLW5H5hTF+t6LWyKGk2tnR5x/HGzhmj1DBZaLUk0jbhXfa+DEXJv5dZgPAQ2Lo5UKSsshUbTbe1SAGNJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <1101472@bugs.debian.org>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <jan.kiszka@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Bug report for aide
Thread-Topic: Bug report for aide
Thread-Index: AQHbn66N799ZyBX7g0q7zd7FIzi6DQ==
Date: Fri, 28 Mar 2025 07:09:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB1483830B5E01D17DDA422715EC2A02@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|OS3PR01MB6021:EE_
x-ms-office365-filtering-correlation-id: 5a6e324c-4937-4fd8-7ac4-08dd6dc77a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b1JldWE0WDNLa1EzZ1FOQ1hwMDVmeU50V0p3NmEvL2VWSkQreEdFbm10?=
 =?iso-2022-jp?B?RGtpZnVuSEdkVmV4R3poWW1iV2l5YUx3Nlh1UGFIdFp1bUpWUExoOTJE?=
 =?iso-2022-jp?B?MmZ3NVJJZCtpUmp2TW42UExlQ1VoOE5KbmoxbndhWGladmVKWStEY0Z3?=
 =?iso-2022-jp?B?aVN0SVNydW9UVG43MUt1YkNaRlZmdmpDeUhIQnpPdUE4cGlFVUF0ZmlS?=
 =?iso-2022-jp?B?N1c3bHVHbFJhdUp4RjBIbzRzU1NYWmJRTlJYdGxmTlRqM1ZHUDlFaitH?=
 =?iso-2022-jp?B?bnFzcStSWm5wTllVUldwOHBtaGV4U1NoVHdadTBTbEZzakZtQXVSZTg4?=
 =?iso-2022-jp?B?clk0VlIydnI5WmJSVW0vT3IvSk5kRHd3bmUrOUZmcWNTa2lRVnB0YkRB?=
 =?iso-2022-jp?B?RlJiK0FkZFlBV09OLzRPMzBnNkxaeC9hVEg0S3FWUEFFdDAwT2ZoUm9Z?=
 =?iso-2022-jp?B?RHJNL09wck9kUXhpT3dWOVJHWks3UWdaWDlSOTdvVDlLRkZicTlRM3U2?=
 =?iso-2022-jp?B?MStEVnpyV0s5Nkp6NDl2NXhTQWQwTXM1ZUZRc2pmUjhSUlMwMm5sQ1or?=
 =?iso-2022-jp?B?ZG5MYmpKaVlYYnZTVS9xbUprMTlUaWludEN6SEJvZS9tQ0FiWTYrZTNp?=
 =?iso-2022-jp?B?bW8zNmgvdkUzNWp1Qk41MDhtM0Y2dzV0b3JIaE1PZG1GL0lvV2tRUUpK?=
 =?iso-2022-jp?B?VU8vZFpwdzRhUk1zK3Z5WkRiZjhmNWJ1UE1QRDM2RG8vTmRyeG5sSXpJ?=
 =?iso-2022-jp?B?VVV0eVRLL3d4M3FJRGlaaVBNNFlxNnlDeS8xckltMHN0VHFtZG5rOFZG?=
 =?iso-2022-jp?B?TGpxU2QzY2JSYXV2N0FKdFFjVEwxaCtqbjlrNVFoVGZxZ2Z1dm5UODVi?=
 =?iso-2022-jp?B?SEtJR3JKS2x2WGFmOEFtaTcveW53VzdrUk4xSWR6ZDg3VExqTC9YK25y?=
 =?iso-2022-jp?B?YVFLYWRlbmdNYis4cHN3aUh3a3Vqa2dBZlpyVUhNSjZ1UmNEb0MwODZY?=
 =?iso-2022-jp?B?VUhkUk5zZGpuQWJURkNHdVY2VHFlb0gyM1JTTi91bnB3VlRGN2F4cDR2?=
 =?iso-2022-jp?B?S0h3TWw3NVVidzZFeTV6eGo1cW9DK3ZhelpWTFJvdVM0TjNUUkx4LzNZ?=
 =?iso-2022-jp?B?dzFQZ3JkUzlhTmN0dDBxOEpEQXhnb3FSb2s4OXVLK25xWmVoamo1d0lB?=
 =?iso-2022-jp?B?Y0VOSzE2dlk2YVBxUjdDVXpXN3FSYUxrdUdJRlRRUnNiRm9sYTgyQW9F?=
 =?iso-2022-jp?B?dFRpRVA5NkY0cktHL3B3MUpoVklsQWRrQnRxVC9jcVRFRWlKK1hVOWc3?=
 =?iso-2022-jp?B?eFp3bXpwVmcyVEhITFZiZGJ4UFhzcndzY0FyUUJMU0xPdWw5YlpOVjNt?=
 =?iso-2022-jp?B?NzQ0UXhOa3NEOXNQL1JXSWRyaytiRVpualFGMGlCSVNjRlYwTDgxcytE?=
 =?iso-2022-jp?B?enUzNHBBLzBqKzhDcGJzdnp5dWVFQ3hJbng2Tk41QzE3TEdmQ0dLWGVq?=
 =?iso-2022-jp?B?Ui8vdjNNVGZkRk5SSCt4MzdUeGo5RE5scjgzZ1dPbHgwZThhRkVKakRk?=
 =?iso-2022-jp?B?M1RiVlpiWEJUQmVrM1F1dWlOT1pUMTVTcEtMRjRLM21aWWFKRnNKYndZ?=
 =?iso-2022-jp?B?L0R0dThKZ1lyS0h4d0QwQ01BQ2tPd0hTamR3SUJaUHZMcjRxb3JYT0Vh?=
 =?iso-2022-jp?B?bVlNV05ncHFnUk03ZW5qbFlOWSt6WGlmTHFJRlZGNkFMbXEzN09KNndu?=
 =?iso-2022-jp?B?REFodUtrenF1dkNqT1JiZkg5dDZsUkxKd1IxMXpWSFE0cmppQ0hDanAr?=
 =?iso-2022-jp?B?Q21mZHIzUndhVjY1YU9rWlA5T0NDMlJUQmo1eG1UQVFLSEhnUXZoWk1B?=
 =?iso-2022-jp?B?d1RMdVpwU2ZwQ2F2ZnlRdUFqbWtBN1o5eEIxSWo3K2gvWWRaaVVLcm1h?=
 =?iso-2022-jp?B?MVFuRXE5cTljbVBGNkxvU3Z6bHRVcXBXUHBBS0RMUDZrMGxBdmpkbXhy?=
 =?iso-2022-jp?B?S3FhRXBIRUhwVlpHSnVENzN0Z05mcklNUWJ4empma2dXVWtTbmMySW1V?=
 =?iso-2022-jp?B?RFZkUmI4L3MyMW5XWWk2S0tlajE4MStBQmtpTWU0SkFZN2RkakdSUUgr?=
 =?iso-2022-jp?B?NDk=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bXNNWjh6d3BiZFJWejlRZWV4TXU0Qk8vaFlHRjI3cThja1phamtSeG1P?=
 =?iso-2022-jp?B?cUVIUktYNEJyUWxUcFI4SnJjc3ZHdnRTYzVKRnRjZm9Jei9wdVRnMmQ4?=
 =?iso-2022-jp?B?KzlzL2xZOElMZU1CWldmZ0l3dUIzd0xPOTVEVXpxcEFZK21NVVFCbmR5?=
 =?iso-2022-jp?B?VDlMN3BjdXNrbFZuRjJjaFE2a0t2c3MrVitwY2VRc0VqNTJ4WUUxajlx?=
 =?iso-2022-jp?B?RWRhVmthN1FFVFJnZWwvbVdnYlFxSEdoLy9jUnF5QndiU056MGVQYUxl?=
 =?iso-2022-jp?B?dlNqWEVxQ2I3aFgzY2ZFczZZL0Z2NmRsMkt0blppZVg3TS9yM1NGdFdL?=
 =?iso-2022-jp?B?VEN1cERLcVhSaUgyZjJtT1BHZUtXclZ5anFSVjM2YVppKzFDOEZIb1Iy?=
 =?iso-2022-jp?B?MEZ5REFxK3psODdEYWt2OXBzc2Zha3l5cnp6Tm5waEMrenpYMUhOMzBv?=
 =?iso-2022-jp?B?cVdUZnRvK0RUY08vUU1qakcvQnNhejIwWXQvMDVIcmIyWElBS1ZuckJJ?=
 =?iso-2022-jp?B?QzhNakVJTnpqQXQvWmJhNzYvWjh4SjVjbnJraGVmcmRUNHFoSHEvcGxv?=
 =?iso-2022-jp?B?NHBXY011OHhEOGNTLzdEdGZHd2xwUlNxUnFZWFlvOERmQTZNc2ZrWVFq?=
 =?iso-2022-jp?B?a0xNM1phSjc3L0JNdXV3Y0hnN2lsa0wwOS8wMlpoMElmY1MxN2FHM0Vm?=
 =?iso-2022-jp?B?ZFdWbGJkM1dmNEo1Mll1NXBnTEQzZENKV2hIeFBycWJSMUwvaHJkOUI5?=
 =?iso-2022-jp?B?QXVLbk9wYTN6TG5lM1R6bjJVVmhRTlVTUTlVQ3QxUGxOM2NRYStNbFl0?=
 =?iso-2022-jp?B?NklOempWakc2NzBXZDZzZW1lWGovN1ZMZnR6ZnVVVHJxVHZaQjZkNU9W?=
 =?iso-2022-jp?B?azh3WldhMWFTTWdXa2FldFVYSThaekkxNk9JaGR6MXVGNGxMREg0ZXY5?=
 =?iso-2022-jp?B?UHNBUllSSS9hQlYzWjM4NzN2cjEwWkZtTnNsUDllY3JHNG1HbGxOVjkx?=
 =?iso-2022-jp?B?Rk1GeTdYMExVWk41bmtkQ0RVejVtUDZ1UzVxcG8wbXVyVXVJSUFsSWx4?=
 =?iso-2022-jp?B?QTRhSFVETGdrdnJ5VmRheWlnRy9GcXdkV0pEUit5ZVF6eWh4UURrcnAv?=
 =?iso-2022-jp?B?cDBTeS9FcWtXVnlPUlREN0hnQS9ac3RCaWh5RWRESHVBZGptRGZUUEZ0?=
 =?iso-2022-jp?B?TEp3V3N6SnM2M1ZKRGVpSWQ2ajUxdFVQSEoyMzZ4Rlg0bHFPVlRITWp5?=
 =?iso-2022-jp?B?NkpzSC92RWJUalJLQnVzVWxic1hPYXc4cER3MTZpMXQvY2hxd3plTXN6?=
 =?iso-2022-jp?B?VkRETDZBUk1YWDFTREhVWTU5ZVJQTm9wSDZQZmt6clVLazIrNkppbWR6?=
 =?iso-2022-jp?B?aVVBSXRHd2VHRjl6Q1ZYbXFmNzRhaHlzQ0lBTEhTWTN6YVhjQnRQTUt3?=
 =?iso-2022-jp?B?QWVFR3VSMTBPQ2w0S2RKeWRiN0daVGQwRWpjaGV1QUtGU3ZkdFFNekRt?=
 =?iso-2022-jp?B?dWtocWVpUzE1aFZQTC9menZOaXFkS2FiU1VIWXNkOGNoSGpvSGp3dUdk?=
 =?iso-2022-jp?B?WC9Wd0NtRmtzalJwUUpDTHBmaWwvQVBoZ2FlRExxQVRmbFNWTTFRREpT?=
 =?iso-2022-jp?B?Wjl1VTJCRFg3OVhGM2wwNmRYRVZyeHhKbEt0eFU1bXdXR0ZIcmZITkFi?=
 =?iso-2022-jp?B?NnVydUV4RTRSazZHdERYb2xwa3dBMWlJZ3pJQ0ZUWXNEbHNjK0xoMHdP?=
 =?iso-2022-jp?B?T2R4YmdCR3Y4WHZGeXBrR3RNQ2p1VVhlYVBDSzVpUkx2VVcxcEM1Zklq?=
 =?iso-2022-jp?B?WmNiNVJmYWNoQXVUT2tTd2wvN1hva29mQlVkTk53OFQwaWRLMXF2T0c1?=
 =?iso-2022-jp?B?VUdsVW5zMmF3Unk5Qlc3V2NxWFFzVTdLY0JUU01rWVlPbkJJUVlMUDg1?=
 =?iso-2022-jp?B?eTA0VzBmSTBRY25jRGpBNVhsYkJET1l0YU16N04zeUhCZkdSb1N2UDQ3?=
 =?iso-2022-jp?B?NVNEcURRckRsSXJIYmRVdlBISitPRXFpeHpHQmo1dFVLUG51MENFR3Jr?=
 =?iso-2022-jp?B?djIwL2JPcWJ1MVIrc25GVnNTamsycm1GcFB0YTdFajArYlJNVUh0U3pt?=
 =?iso-2022-jp?B?K0VEQkVsVFRqZTljanU3bE9lQ2RSTDJrZUhnaFNXditzaHlXMXdCYk04?=
 =?iso-2022-jp?B?bm1CenUzQkFQZFVlc2hTNC85dVkzVDZWMW0xVDZGZEVyV1dJdmtrR0hL?=
 =?iso-2022-jp?B?dzg4ZUdOQVVVcGNCNzh6YlhyRm5hWk1kcXE1WStXRDU2cURaemdQSWJi?=
 =?iso-2022-jp?B?dm51b2lZVmhjOEYrM2l4OW1jcmNIcHBGbGc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB1483830B5E01D17DDA422715EC2A02OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6e324c-4937-4fd8-7ac4-08dd6dc77a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 07:09:27.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVnKRi07ycwniy+9ms+4GFmOCwYsdMnGTnlXcNQyNAfY5MA5MO8iHk8mSQlueftd2cPiggA6DcdMRWXaIg9+CngO1cFWk3rTvNIL5HMQ6d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6021
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Mar 2025 07:09:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18385

--_000_OSCPR01MB1483830B5E01D17DDA422715EC2A02OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Marc,


>>It is unlikely that a rule that is just appended to the configuration
>>will work as expected. Order matters.


>>To be able to insert local rules at the "right" place of config, aide's
>>Debian packages work with configuration snippets in
>>/etc/aide/aide.conf.d. Try putting your rule in there.


Thanks for your quick response.  In the scenario I tried there is only a si=
ngle rule
that I used. I am still not sure what "right" place means here. I will chec=
k further on this.

>>This is not a bug, closing this report. For questions about basic aide
>>usage, please refer to the mailing list.

>>Also, what do you mean by "aide is unable to report"?


By "aide is unable to report", I meant after explicitly modifying the file =
and running an aide check,
"AIDE found differences between database and filesystem!!" message is not r=
eported in system logs.

Thanks & Regards,
Sai Ashrith




--_000_OSCPR01MB1483830B5E01D17DDA422715EC2A02OSCPR01MB14838jp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Marc,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<pre style=3D"margin-top: 0px; padding-top: 8px;"><div class=3D"elementToPr=
oof" style=3D"text-align: left; text-indent: 0px; white-space: pre-wrap; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&gt;&gt;It is unlike=
ly that a rule that is just appended to the configuration =0A=
&gt;&gt;will work as expected. Order matters.=0A=
</div><div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; white-space: pre-wrap; font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0);">=0A=
&gt;&gt;To be able to insert local rules at the &quot;right&quot; place of =
config, aide's =0A=
&gt;&gt;Debian packages work with configuration snippets in =0A=
&gt;&gt;/etc/aide/aide.conf.d. Try putting your rule in there.=0A=
</div><div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);"><br></div><div class=3D"elementToProof" style=3D"text-align: left;=
 text-indent: 0px; white-space: normal; font-family: Aptos, Aptos_EmbeddedF=
ont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">Thanks for your quick response.&nbsp; In the scenario=
 I tried there is only a single rule</div><div class=3D"elementToProof" sty=
le=3D"text-align: left; text-indent: 0px; white-space: normal; font-family:=
 Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">that I used. I am still not su=
re what &quot;right&quot; place means here. I will check further on this.</=
div><div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0=
px; white-space: pre-wrap; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">=0A=
&gt;&gt;This is not a bug, closing this report. For questions about basic a=
ide =0A=
&gt;&gt;usage, please refer to the mailing list.</div><div class=3D"element=
ToProof" style=3D"text-align: left; text-indent: 0px; white-space: normal; =
font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br></div><div cla=
ss=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; white-sp=
ace: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&gt;&=
gt;Also, what do you mean by &quot;aide is unable to report&quot;?=0A=
</div><div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);"><br></div><div class=3D"elementToProof" style=3D"text-align: left;=
 text-indent: 0px; white-space: normal; font-family: Aptos, Aptos_EmbeddedF=
ont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">By &quot;aide is unable to report&quot;, I meant afte=
r explicitly modifying the file and running an aide check,</div><div class=
=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; font-famil=
y: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);"><b>&quot;AIDE found differen=
ces between database and filesystem!!&quot; </b>message is not reported in =
system logs.</div><div class=3D"elementToProof" style=3D"text-align: left; =
text-indent: 0px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);"><br></div><div class=3D"elementToProof" style=3D"text-=
align: left; text-indent: 0px; font-family: Aptos, Aptos_EmbeddedFont, Apto=
s_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);">Thanks &amp; Regards,</div><div class=3D"elementToProof" style=
=3D"text-align: left; text-indent: 0px; font-family: Aptos, Aptos_EmbeddedF=
ont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">Sai Ashrith</div><div class=3D"elementToProof" style=
=3D"text-align: left; text-indent: 0px; white-space: normal; font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);"><br></div></pre>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_OSCPR01MB1483830B5E01D17DDA422715EC2A02OSCPR01MB14838jp_--


