Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35EDC021A4
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 04:28:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.655.1740544078642030726
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2025 20:27:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 51Q4Ruub506710; Wed, 26 Feb 2025 13:27:56 +0900
X-Iguazu-Qid: 2rWhg4sy16itejCGho
X-Iguazu-QSIG: v=2; s=0; t=1740544075; q=2rWhg4sy16itejCGho; m=pqiWGqtofMZzN7GTLum55izuAkWRA8OsMFKA5XZ5ZdI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 51Q4RsF62601847
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 13:27:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1BpybPTZwhf52XBT4mlUlpte8ma1RoqIs3fv0Por3kmutWP8iIMmCJT/LY1GrIBRq79TfJwF5agY6dI5QlD+vdyHTK5EeAuKj2jXUrMNf0oVA93j+FbSHPt4WQnr9Vx9IZPmU9W2tmjzZ5cZQyeRF+h0bp5RqaUNVueLV72MhUZVrTkE4XTi45kR2Z8ucLgdoLXPvIVE4LvhHqGaB3TOEm0VoNr7llKPWoBkgH50OL+rusyuFCgLhKnFGeQe1FqJbo9+G2aa/VOMIcaS/medITK6gafmc8I2wp7dMA3jhxOtIaAmg9x50Ig+1GdNnAysj6SH6+lhxwfpyfgCLFWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGaov6WZ20p7WXnaOZW3iHvUDuZ12GL2JSfzC0ydWgc=;
 b=GNgmm8ljjlYprYmD4S2SpLoafL9UDOx7PoYltpO5fG2frsSx5YacR3tkZDolpl1wXxSYzw9ChmhbUna79VFjhGj+XvejInd03Y71eB1tE+N7688KL/wb06X7S2Wk+l2UvQleMOP+yuMC4I1VYlZrCZiJCTLOC+lqypoyEfcuu0bjxdRWUtbNRS43FyYRVjiELdjD5pH+EQEVqZ+jqgIqnzlHxiVRSm8kbY13ESbQ250DAivfoYRtJxLYQD79QIqV4a6SDt/UzgYNk6x9FAgkoCMpflwHRT+55g2Haye9de2AD4QRf7iP+myPk7u0fPdhzuDD6mWo6pgVcTVxgA///Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Updating root file system used for kernel testing
Thread-Topic: Updating root file system used for kernel testing
Thread-Index: AQHbiAY0k37sypfPYkK+BZ6qIlAP7Q==
Date: Wed, 26 Feb 2025 04:27:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB1483816E3365201CB54911E2FC2C22@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TYWPR01MB9984:EE_
x-ms-office365-filtering-correlation-id: bb7d4c1a-7c41-47db-52dd-08dd561def2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|38070700018|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SW1Xc0pDelY0S2xseWVrcVRmbTRhUnVKWkJ2b0RQamw2clNBTDc0dGtR?=
 =?iso-2022-jp?B?bkQ3Sk5iQlhMSVR3OHgzVm9XWlNMODg1SkFCUTFqMnhzWUdmcTZENXov?=
 =?iso-2022-jp?B?NVVxcXl0QjVhNGxnWkJ4TTFpOFFUL1pxSlN6QTNYdG5jcThSQ1cyd1ZR?=
 =?iso-2022-jp?B?U3c0QVpEZE5UcTllNVdSZVVzb3VlNC9Db2tZOWpTSUFDdnZ4MzE2UXQy?=
 =?iso-2022-jp?B?dFF0QTN5WGJTM1R3UHJQaXkrNURxcXpSeXRNWHZleXp4WWJLUE1DYnlu?=
 =?iso-2022-jp?B?WW84S0JJSzFKT21YeGdyaklQRlBPOHpBUGNpNWw4QzZ0QzhVR0ZoUDhF?=
 =?iso-2022-jp?B?cEc4eEhyQzZHY1BDVDBqZUw3YldTZFg1Z0R5Zk81WUVaN2tKZEoyRmJp?=
 =?iso-2022-jp?B?cXdrVFg3M2lCZ1h0ZjFMNUV0WGFpdGF2RXljZ0RidDZWWVJiWm1oMUJH?=
 =?iso-2022-jp?B?eEtPeCszNlB0b3VKTDVzRjhmTW1EZ0lhY0xZRU45eHFHSE8vaFRFVkkv?=
 =?iso-2022-jp?B?UEh1WVd3eXFONEszRHlZSXBSeVNJNmZuYS90SEpoVkM5RlB0TDBPZXQ4?=
 =?iso-2022-jp?B?SXRMQzl2a1VvRytMdU4vUHlUK1M4NnVmNmIxZytKSGkvczFRUzhrSWNq?=
 =?iso-2022-jp?B?QmdtR3BLRzQycGxYb29XUlgwbzFnTTQ0WXpvL3ZPbW1QWGJzSTYxZXVY?=
 =?iso-2022-jp?B?Q1BjN2R3V3FIQUhjVUhJM0lQL2lyY0Q1U3duR0ZjbnNTV2hQcy91NnVP?=
 =?iso-2022-jp?B?dm5NK3duN3gvRVd3alZHeWp4Z3RVaWxTRi9zVEV6aTc0UGhyTDRyKzJj?=
 =?iso-2022-jp?B?OHBKbXBoVkZxUzFpWFh1bXViS3FrbGVoNU01blYzRzMxN1drcGFFeEZL?=
 =?iso-2022-jp?B?cjdiTXQ2OWVVRXVzMHFzZlF2WUVUeTV6MCsrbVdEV0xQUmR3M0tOZENa?=
 =?iso-2022-jp?B?VTRDWkFISlRrZzJLT1R6MTFJV3JRMmRNNTZwQXpBOC8yTEE0RVJ5d1dx?=
 =?iso-2022-jp?B?cjZlR3dWYkF3WlRRcTlOS0VIMXB2cklUdlo0TFlpZDBkR3BkbWk4bDlv?=
 =?iso-2022-jp?B?eHN0MWovQTkwbmhVWUIrMzlXTDVzS0ZRdGovVjY1YWc5VEhPMzlTRVkw?=
 =?iso-2022-jp?B?bW9PbHFFb1d5SituaFBjNkVTbW5wR1BqMHNtMlllTmRoS3hwTytMM2Ix?=
 =?iso-2022-jp?B?Y0QzT1NEanFhb3ZNRXZmS2s2V0ZjWWp3Qnh4SjVxSVFZZUJxdjlsUkc3?=
 =?iso-2022-jp?B?UktvNHVkUzJuT0VUVHl4dHhNcjVJdU5YeHpzTGdRMUZlVHdvcjF3V1dp?=
 =?iso-2022-jp?B?Z0RNVUJCVDhPckFCcnZpSlROZkZxRFh1Zk04c1hoTjM0SmgwZzcvS1c0?=
 =?iso-2022-jp?B?N3kwdDd5Q2N1WjNTZmEwdy9tdVNnZXZMRFByWXI1d2dEaTI2RHd2VmRa?=
 =?iso-2022-jp?B?RmNicnJkNzU4aE5SblNjZURkcDFoUjl4U0RYNFE3MTNhSDRSRFFHbjl6?=
 =?iso-2022-jp?B?aWx1aXRzS0VkV1d0U3JmeWZWOXNLb3dORTNpZE5wbGtQUE5NY0NUVlZL?=
 =?iso-2022-jp?B?ZG0rZXgrRGQySjEza1NwOXlLTHhVT1NOVUphOVc1cFRwbDVqVlYwZFpz?=
 =?iso-2022-jp?B?VFAxYXJ3ZTZVbHFwRmN0a3BJOXdkMTJVL28rdHJOeU9XbUhLSFZwRC8v?=
 =?iso-2022-jp?B?V3JMS0grcVprWmtpYjZVUmN1N29UYVZRdmRzNldZTlNDc3lEMzlabVly?=
 =?iso-2022-jp?B?Q1U3Zng2Zjd3WVVWbFJpK2czZGN3UTY4RFFWaHMrdVFrZDRFQjRMSEx4?=
 =?iso-2022-jp?B?NXI5aUxGUVJwY1c1aXBmM2JFdDJDNU1JZUxBRlRXNkNPd0VrM3FZVm03?=
 =?iso-2022-jp?B?N2ZaNC8xRjFKNVpBVmVLSUpEM0toS3M5eXc1UHI4VG1naXhBWVBGMm9I?=
 =?iso-2022-jp?B?amtWQ01VUklyTHh4SE12QlExbU5EYXJLNjNWNS96TkFEV2VCdXcvSHBC?=
 =?iso-2022-jp?B?S1BvNWNvaXhpOFExUnk0dWpsaW56dA==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cWxjV0tSaVZsQjZ2bkFDM1BUWThTNUxZeFJCMnhVNG0wQTR4U1dOckVG?=
 =?iso-2022-jp?B?N0JZc1NYV0FLYkpkaHhXbEdqTnpkS25OaVJ5VnJZbTIxdDdVVVpHT3dh?=
 =?iso-2022-jp?B?ZnlNZ2NhMVM0N09yRjBTVGs0UGJFUXdIQVcwU0M1SEZrY3FHSXh1a0FY?=
 =?iso-2022-jp?B?VWF6bGZ0NUI3TTdGdTVsUFF6U3J4UjVyRm0vZ0hxVkhPWnd4RXBYWGY2?=
 =?iso-2022-jp?B?R0JkSjJ1Y2F1d2psVzV3cXBCUDczYXpjN0VoNWVLOTBUM1ovS1h1R1h1?=
 =?iso-2022-jp?B?eVVRNkYzWUM0dVg5N0JicUNmTzdpalZoSlU1TVNISHdNbE5Dbyt2emRp?=
 =?iso-2022-jp?B?WTlUSzJkVU9IUWtnT3YzNnlNSWxXdjhBTm9LK0FpU051SDN2b241WWQ5?=
 =?iso-2022-jp?B?THJoWWJVMmtIYUFWakR4SWVTK3BPVEhSWnhQSllFenN2MjgyMDZSWWNB?=
 =?iso-2022-jp?B?c2tsdld2TGI2VXBMclVoN3JrdVo3b09GZjJ5dGxhR21OcVV3elVYc2g3?=
 =?iso-2022-jp?B?alZlWDFNd3NUb29JaHl6eDEvb1pmQjJKSGd5VGg5ZzdVTE83czJuMUh4?=
 =?iso-2022-jp?B?ejg1SjNUZnRvaFZmbVFMNjlZbWYraGFRbndRWi9VVU54dzNRWWRBUTBO?=
 =?iso-2022-jp?B?cW5RbDVRZG5OSXZIclU3dE5uNGdKVGpEWE1VdWZTTTQxU2JhQWVMd29n?=
 =?iso-2022-jp?B?M2llODNnNlgrb1JjTzlncytnWjhIVFN0N1ZDN1ZYbGNiU2dzZ2VYTHNn?=
 =?iso-2022-jp?B?ZkdYNEtUVVJGSmNVVWZZbGNWcDRENC96NitXQ3Z3RFRJUzg1dkpFNm16?=
 =?iso-2022-jp?B?M2JUQXFJS1ZIUCtMOEF6bUUzYzJFUmE0aE5US3c4SnBmclJZRTB3eWVI?=
 =?iso-2022-jp?B?bzZWazhMUDMrWnRnbWo1Z2xZY1E2dDJUblBWbFhUZDZ5Rys1SHBIcE56?=
 =?iso-2022-jp?B?WHJhOEthSVJVYkQ5Y0Y4SnVIQkNsbHgwVmRDOFNoTzB3WHpUb04wOTRk?=
 =?iso-2022-jp?B?aHpHalN1L1pVamZCRC9xUUVhK0JkOUlqVUZIL1NGM3dLcERSc2VqSXE5?=
 =?iso-2022-jp?B?NXg2TWpVb3NUa1FMNndjYnBYNUhYb3U2MldWQnJhNUVWSTlpbU4xdFZS?=
 =?iso-2022-jp?B?UEdGWUdrdWkwWVpzV2dzWDNmeTJiMHhKSUlob3A2bVhmOXc4Z1Z6ZG4x?=
 =?iso-2022-jp?B?T0h4MjRYcEhNQzNjNFUrOEhySDV4dGVabFJHbHFKQ0d6Mm42UG5wUmZW?=
 =?iso-2022-jp?B?cjB4VlUyUzBGRVAxUE5NNEJ1ZzJ4MFB1WlFMNUR0dlRIRjVBOE8zTXN5?=
 =?iso-2022-jp?B?ckpZWDAwUXJmai9wdHZHdzlvUDVhN015b1BERHRSeTJxUUJxeUZWZmtK?=
 =?iso-2022-jp?B?c29yQmV3dTZvcEpsRTVYUHpIRTBMSmtPeFZ3UXRFWGRJYTY0QkFJMEY5?=
 =?iso-2022-jp?B?UXZ5bERQVGhzRUJLQTBxaVlsR2RRdmczaVNMRHlHZFdhVTZYbUo2RG5L?=
 =?iso-2022-jp?B?ZHJLK0M1Vy90aWErdWFjOEsrMHNxdE1LeDE2ZGJ4bzhhMitCZlpFTWRj?=
 =?iso-2022-jp?B?dWRPbWlrNUVYcC9ZbDh2UDdITkxzNThHUGhzZWdRYU1wd2x2N3gyOTZG?=
 =?iso-2022-jp?B?QUo0bm9kM0Q0NEkveXVlSmRvVHNPaTZwWTdOTEJDN0p2OUNNMUg0MExM?=
 =?iso-2022-jp?B?YjI1MmlLNmlMWFZ3WlMwR3lEYkNuZjBqdWNhMXlsU2plOTZpOVE4N0tM?=
 =?iso-2022-jp?B?dStWSytXdW5yM0FQbDN4Z2E5MVBZQ3JFZ2VGRm81QVFpSURqNlNSWG05?=
 =?iso-2022-jp?B?MDgvVVgzUnU3V2RBUHVWWWg3bURsajIzTVp1ZGttZ2ZvTDZjRzRoSU5W?=
 =?iso-2022-jp?B?K3BuNWFZTjZQanRkVXd6eUVRcnUwMXZ1TnFIRTZWVGh0eTNLM2h4ek0z?=
 =?iso-2022-jp?B?Skl2K1dCaW1ONGZNdVU1ZThVVVNxeUhyNTVuTUE3UWNXazNvbWFTUG9I?=
 =?iso-2022-jp?B?aW96QVVDOVkzdlRRVDZLb0tnYWkrWFpueHVvMnVrVWZtcldnYU9QY0wv?=
 =?iso-2022-jp?B?azNMQThFMFRVVkFiUWZxQ09ieDZJalFRc0luRzEwY01iMmk3R2pQNm9u?=
 =?iso-2022-jp?B?MHU3eHNqTVlBSWJ0MXlrdVBuQjBHVmRXWDErVHYxSzBMK0dMNU16QUhr?=
 =?iso-2022-jp?B?VnUwQlNtTVFPOHhRZi9EVlRtZk5Td0x1VzhjK3BTVUdaK2lJeXpYYWw1?=
 =?iso-2022-jp?B?RzFOc0lXM01BdHVWY2I4V1RjRDdKTmZRRlFpWDZURkF0NlVmajhpNVBh?=
 =?iso-2022-jp?B?OHh2b1RYdjA3L2VtUVQ5RDBrZXdidU1yL2c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB1483816E3365201CB54911E2FC2C22OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7d4c1a-7c41-47db-52dd-08dd561def2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 04:27:52.3031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gsc98fzye5gZWPN7rkXzN6yPSVZ3Ss0Vbg2nMIhGlVQO3frbOoCP+ZANkMsuPMB2LqHslLExLJGxT3S41psDo9YQCxPfh5Dy0JpBQmRMQo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9984
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 04:28:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17912

--_000_OSCPR01MB1483816E3365201CB54911E2FC2C22OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Hope you are doing good.

We noticed that the LTP version being used in the following rootfs tarballs=
 used for kernel testing are not recent ones.


  1.
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qemu-arm64.ext4.xz
  2.
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qemu-arm.ext4.xz
  3.
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemux86-64.ext4.xz

Do you have any plan to keep these rootfs tarballs updated with the latest =
version of LTP through CI ? If not immediately then we want to make changes=
 so TWG always uses latest rootfs tarballs for kernel testing.

Thanks and regards,
Sai Ashrith


--_000_OSCPR01MB1483816E3365201CB54911E2FC2C22OSCPR01MB14838jp_
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
Hi Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hope you are doing good.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
We noticed that the LTP version being used in the following rootfs tarballs=
 used for kernel testing are not recent ones.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"text-align: left; list-style=
-type: decimal; background-color: rgb(255, 255, 255);">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin: 0px;"><code><a href=3D"https://s3-eu-central-1.amazon=
aws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/cip-cor=
e-image-cip-core-bullseye-qemu-arm64.ext4.xz" id=3D"OWA3fc257e6-e110-7793-0=
280-6032b15b39b8" class=3D"x_OWAAutoLink" title=3D"https://s3-eu-central-1.=
amazonaws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/c=
ip-core-image-cip-core-bullseye-qemu-arm64.ext4.xz" data-auth=3D"NotApplica=
ble" data-linkindex=3D"0" data-ogsc=3D"" style=3D"margin: 0px;">https://s3-=
eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing/lava-healt=
hchecks/rfs/cip-core-image-cip-core-bullseye-qemu-arm64.ext4.xz</a></code><=
/div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin: 0px;"><code><a href=3D"https://s3-eu-central-1.amazon=
aws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/cip-cor=
e-image-cip-core-bullseye-qemu-arm.ext4.xz" id=3D"OWA1c9baaa9-224c-ac28-2dd=
4-67775a44db43" class=3D"OWAAutoLink" title=3D"https://s3-eu-central-1.amaz=
onaws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/cip-c=
ore-image-cip-core-bullseye-qemu-arm.ext4.xz" data-auth=3D"NotApplicable" d=
ata-linkindex=3D"1" data-ogsc=3D"" style=3D"margin: 0px;">https://s3-eu-cen=
tral-1.amazonaws.com/download2.cip-project.org/cip-testing/lava-healthcheck=
s/rfs/cip-core-image-cip-core-bullseye-qemu-arm.ext4.xz</a></code></div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin: 0px;"><code><a href=3D"https://s3-eu-central-1.amazon=
aws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-im=
age-minimal-qemux86-64.ext4.xz" id=3D"OWAf9e8fad7-2742-198f-4b35-9f71794336=
ba" class=3D"OWAAutoLink" title=3D"https://s3-eu-central-1.amazonaws.com/do=
wnload2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minima=
l-qemux86-64.ext4.xz" data-auth=3D"NotApplicable" data-linkindex=3D"2" data=
-ogsc=3D"" style=3D"margin: 0px;">https://s3-eu-central-1.amazonaws.com/dow=
nload2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal=
-qemux86-64.ext4.xz</a></code></div>
</li></ol>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-size: 12pt;">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Do you have any plan=
 to keep these rootfs tarballs updated with the latest version of LTP throu=
gh CI ? If not immediately then
</span><span style=3D"font-family: Aptos, sans-serif; color: rgb(0, 0, 0);"=
>we want to make changes so TWG always uses latest rootfs tarballs for kern=
el testing.</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_OSCPR01MB1483816E3365201CB54911E2FC2C22OSCPR01MB14838jp_--


