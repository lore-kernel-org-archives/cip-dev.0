Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17AECAC5A7
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 12:23:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.10285.1758803032117049516
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 05:23:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=qeUIoiqp;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1758803009;x=1760012609;bh=
	41b1gnUwIOgjo6oamKnpbBFaSOjSTm0nzIF+ZS2UmeQ=;b=qeUIoiqpLXhaPiaWtFRGHbwlLY/oO2
	h+48IxA9Q7jdIQZAC2N4zGxI7PUMMiSCF+Wqz8iD5nj2+XoYU8Rl3fHA7qAf4Ic6LvArCSjvfjC82
	8hp3wfcrW2UROqulhXiBKK5i9DGQrWmZs7MchWt3yTAQMKjwOeboQlzhLbNC4ryUxGQ7Mh7+5A0jB
	EaykdCNDF5rCPwq+THnHcHRhZRwOXHE3qIQrdJgMKWtjPNJiyoCNij57VPHWRcBLHI6wF+bhGNpZ9
	eRQrjQ3xdTWyeeS0gM18gVwqpjchv7X+Y7nUxEZFVWB/0NQ76KF/DE1LxCduDZm/5eo9yOz4m9nyu
	5QDg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 58PCNR2Q1142277; Thu, 25 Sep 2025 21:23:27 +0900
X-Iguazu-Qid: 2yAamy98um1qzYeUFc
X-Iguazu-QSIG: v=2; s=0; t=1758803007; q=2yAamy98um1qzYeUFc; m=KYEd2pCseZFxWG5c1+DBF0ePq9yVoYs0QSesfF6HNUw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cXXtk5DX0zyPQ; Thu, 25 Sep 2025 21:23:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es4SJVJmYSUc0wsL/fsnTjLyRHdBHf5qNgZ6iqlCzfkjoSe7tIJtnS+Zn77zuHcTQxIbPRrY7r7/i+WR473mAKXypLTHljUS7OZuRZD3q7qD1sUuj64aexDu1PMNZyDG5BMHzjfHb2hFx7RV4+5g7lMMSJV95xmcjMdg5pEaD7fytv+h/4ujJi+aV9IB4cfS3qo9RKrt5n9MxefWf3ZtLkqLOHjyk9NlYyA7RbbKlnl/Y0eHrEGq1FPjhudQxDmrsMb1eXGOIKO8R0gT0lEFASIH8alWrpxsn9qIuRdXaCdtpx1OQZlHS9pxuc1M6wIkPN2ECYq0T9lIcesG/YEfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3mxwSa6k2NS/15PAxyUydP63dRX4+NZklSZZHzv6Y4=;
 b=Lz2k8uFoA/ssO+IQ3eTmBWhZf2ThWIZIHXrluU+sP/dleyXStZM+dXetR+ahfAFEo26OcrxllvxOjH+f/wA7XbbkfsFV0VID409ScKICtkOd4wwCsmesTUEO8m3ehYa1+l35l3KRyKK8c/AZj5msj+aBUm7i3mWPW2TYvARp0XAiG3U5C2mCsU6+kXj1Tf+DTEnOWmSY+hzfDjRcTyy7LNYkLMwkEzAjR6rVlWKEMAtTRcCcNYLj55wJGUZqvS2b3UUeALCxGOYUHnBixDLDXxBJn1LSr6qNrevAramrelYHGPb4JDbAGhMiaXigOjNCMXBMkLXcpfdLfIjii9Q4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.48-cip9
Thread-Topic: [ANNOUNCE] Release v6.12.48-cip9
Thread-Index: Adwt/GXOGD/mUSy/TXiNUK/b2yoBog==
Date: Thu, 25 Sep 2025 12:23:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481885F74573656B3D8CB19ACD1FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB9586:EE_
x-ms-office365-filtering-correlation-id: b0b78e45-4876-4373-062d-08ddfc2e5298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?azMxNnZtUFNtQWEwUm9SWmRkQWZFY2cwU0c2aHl4OGRGUHRDWUhxenR2?=
 =?iso-2022-jp?B?Q2IyeGJ6d2JTUW9tRGpaVmttWDhTeUkvL1MyejZoK0kvK05VaUhsOTRT?=
 =?iso-2022-jp?B?cXBORTRrWFhzZCtxVjBmVGtwNDlNeDRLMnhIL1gxZnRHN1FWK3U2ODZT?=
 =?iso-2022-jp?B?RFI2dUhDTWpUUWxqdTdsSWczcVlrRkdUN2twQlp1SFRqTDc0ZWtUMHJ4?=
 =?iso-2022-jp?B?d2c1WnU1UDNON25JTjNyZlVDcUQya09TY0cxMnBBVm9DYVNOYXBiUlg5?=
 =?iso-2022-jp?B?OXRzTUQvWlBUKytNU3BYbHRPMllPWVhCZytUbUNXRVQ3MGFTL05JNUwx?=
 =?iso-2022-jp?B?RStNbnJ4YWNzbHlwTk5DanpvT2RUL0d4S3JZSFg1TnltcjQ4WFlYRkdt?=
 =?iso-2022-jp?B?a3hMd3ZRYWZJNmdrcHdRWlNuUU1mZXdjZTNmdzVJL3ovNzE0WmhHNFc3?=
 =?iso-2022-jp?B?SXNhZGo1ZFFUNmlOZytEbXBBczZWYUgyM3dXTHFuekN2ZmVMQ1VmUjVq?=
 =?iso-2022-jp?B?dThOWTVXcmFpS3JNOXBQRUFiWEhSS3NxYUozbVd5TXJwcENDR21icW5G?=
 =?iso-2022-jp?B?Y3FhdjNsWU1IM3Nwdzh2alRud2F0T2VWeVlKby9JM2NmOVVtVHhiYXJp?=
 =?iso-2022-jp?B?OFpBbFRiOVcyeVZ6d0U3UGV4VFpLNkFQbUZEaEF4R0hUallZeXF6UUtS?=
 =?iso-2022-jp?B?cTl0Y25xbDZaRnJPMmM4Unp4WTBYZFFQSHlXOTFHbFpvT3pVcThuM0pD?=
 =?iso-2022-jp?B?ZTNSU3dqeWdRbUl0MTM0aldQaEJGUzN0c2pFTElJd3NISGhIRVA0U1ZC?=
 =?iso-2022-jp?B?SUNrejROOG85ek1qeEM0ZzhGRjJvTmhjSndWZ1VEdXkyUVhWTlhJUGQy?=
 =?iso-2022-jp?B?NnlMR2hLMC9EazhEZDZJMldyRVdzZjFnV0cvRkpMWFZ6U0dVS0JmR3RT?=
 =?iso-2022-jp?B?NldoSFkzQU5Hb0dzLzNxVjdQRHNMVU5YRVJMS25RS1hxODM0NEVwTG9Q?=
 =?iso-2022-jp?B?VENoZHVPU0M4b2Rlc1kzU2ZUNnQwRjIyMGhQYlM5ZWZYWGk5WjU3Q2ZL?=
 =?iso-2022-jp?B?M1NERll5SWloQkJpbWtsT0xPUDlVaTdXMlFldmJiMFprU3ZyVDN2MzE3?=
 =?iso-2022-jp?B?RUU2aE9xSXhrQ1FIaCtqU2llc3JVMEt5SzVURmxiWlEvaUVyWTYrampR?=
 =?iso-2022-jp?B?Q01yMkJPVFZhb1grZFZralFaU2twbGMvWURyZVVkd3RtZ3Z3N0R6cks5?=
 =?iso-2022-jp?B?eG43TzJqd0w1S250UGExeU1yclZOU2l2YTdPb2NEN2kveWlGLzJMNW5E?=
 =?iso-2022-jp?B?OGtFaFRsbU1nR1Nob0hNdks5cERra2VlOC95SHhIYzluTGkvbkphUFcx?=
 =?iso-2022-jp?B?MzMrM3BDOEFvak1ZSU9seG9wdVZNZm15cUVOZHpaSVIzaUxmUHJta3lG?=
 =?iso-2022-jp?B?MTlsSHVZUU13eWdkbEpFTURBRmdJQmlYaGRER1hab1pvVTdtcVpqanBz?=
 =?iso-2022-jp?B?WUVkL2pFL0dhVy9nc2NPUGd6Nm51amNmSWpEOUhEeGkyVXlCTTZpUDhi?=
 =?iso-2022-jp?B?TUhoMHEzaXErMGRyd0g1M0tJRFR3ZTh6SHZTQS9wdnladG5sYVN6Wk9D?=
 =?iso-2022-jp?B?bnBhT1A0SGVCZ0VadmpSaXVhOHdlaDBmOTFJN2xoT3o2WUJBbDRtc0h5?=
 =?iso-2022-jp?B?STJrSEh0QVluYWdCYkw3ck8yczZodDNCREozMlZzYU5zay9raUNnTXVa?=
 =?iso-2022-jp?B?UGZMWVJBRTZnUGN4dHJTUnRYTnV3RGRSbW1xQXFkcmhLTldoSFo2eXdy?=
 =?iso-2022-jp?B?b1dNeVV4L01wU2cwMVhVT1RkMEQxaXN1YUZYL1hwckpFQSttOG5NVENL?=
 =?iso-2022-jp?B?cTVPMURKZUppcS9lTFlkMG55RXd2eVZJQUwvOTBXWXA4aXJiU2drWmNW?=
 =?iso-2022-jp?B?dnIxTW5CM1BDcS95M2Rsd0FVZnZoajdGdFBQNHlua3ZCN0hQVm9hNWdz?=
 =?iso-2022-jp?B?TjdnSTBLSXROaFBwUnd2dy9KejZyM0txd2V6K3hWaXpKWlRtNkE1N0lw?=
 =?iso-2022-jp?B?czJpTVhuTXlEdEszSTV4UXlMRDFLdnNwTFZMZFRTdVlwUmtEMXM4YVhz?=
 =?iso-2022-jp?B?S0t2aEMrWlFNdWUzMEpCUTJEcUp3aC9zNklBT1FmOHNjV2RQT2d4YW1t?=
 =?iso-2022-jp?B?WVp3T3JXclNVL2lTS2ZYK1dlcnMvbmxT?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?czBvQ2Z3M0hlTDFYZFlXUytRZ0E2VTlLbVZDNDZDbHlvWlQ2VVlKblhT?=
 =?iso-2022-jp?B?QzlETWtROU41ejJtS09VbW8ycXFMV0VrdWptNUM3UUNkbVd4RkpWMTdo?=
 =?iso-2022-jp?B?WUwwcXZuOG1pS2ZwQlRzanhvMTdKZUlLY0ZyaUpxVmwvaEowcUNTMlFU?=
 =?iso-2022-jp?B?M2piL1laNlpmMXJUcXhNdFkya1NUQUJkaFpmeEswdUQyQ1JOb0xMaG92?=
 =?iso-2022-jp?B?TER1T25oTTdBdUhoUVFBQ3g2V1BFK2FWL0dqUWlWRy9mMmh2aEorcVZ6?=
 =?iso-2022-jp?B?QWkxSk9KdGFsbG5RS05BRDBqK1JLM1JNYmkvUlhPTFROK3BsZW4xeVN4?=
 =?iso-2022-jp?B?YUk5Tzd5MFB5VnNxeWU3d2JjT3Yxd3cvMDhWSFhETkdBRzU0dFg0cGpw?=
 =?iso-2022-jp?B?UVFIR0ZqMFE2QTcwR0Q1aEVZVmFNbXJqYjJDRWVrUFhHd2JLOVB5L3Ey?=
 =?iso-2022-jp?B?WTJzNllIZWNLcUtrZUx2cFpiTG5Dc05tekc2ZnduakF4cnRZZklOVWYv?=
 =?iso-2022-jp?B?ODA3ZmJRNXk2dnpqaWdoMTh5L0d2c3RxVS9pbm8wd0ttK0NnWlBpQVE0?=
 =?iso-2022-jp?B?bHI5NTV4WU85NGhRM2tzRllHQ1piMSsrQUplSCtmTkVWWVdTMXZVeXhC?=
 =?iso-2022-jp?B?UUdqcUcrQnJOTkVkb0luWVpBekpGdkphYzBnaW5mZFdvZFowd3dsUkRL?=
 =?iso-2022-jp?B?TUJxa0RQUkdMaU1JdkxFbVhLOThSZHMyZDJtV095VGcvb0FDaGUzbVkv?=
 =?iso-2022-jp?B?M2o3K05jUFJMS2xIaG9NaW9qVVdwUzFEMTY2NHZ0VXkwQmZ5STE3NUZW?=
 =?iso-2022-jp?B?RVIyeTZldWFkUjVkY21IQ1VNc1U0dW5RaHJ1cFQ1MDlkZnRacktONkQw?=
 =?iso-2022-jp?B?ZG00T1JFTnhZTmtSRVMwdkYrQ3JsWWpFZ0NlL0lFTEp1eENwd2w4bGFQ?=
 =?iso-2022-jp?B?L1g0UmNBcEhtMVF6ZFZDd2J6V0pXZWNHWXJqTXNiNzR1d0xhRDFXT3Uy?=
 =?iso-2022-jp?B?bWw4c2M5TndOTVY5L2F6NGtobE9VdzZsMWlXOHdoQ001V3Y0eExzMUNU?=
 =?iso-2022-jp?B?NXZ1WlRDT0krcDlYMlFkR2NZa1ZicVNvVUZkMElCQ3k5bTZXbzZ4Vnp2?=
 =?iso-2022-jp?B?dUM2RjFzMGRrbTN4RUYrSXBFallRb0d5V0hUUDFiM3pMWnJvS0xQS2Ev?=
 =?iso-2022-jp?B?a3pyeExwZEVWL2tLT1NIU2VmUW1DR05RNk5tQ3UwYk96MmlLaDQ5SWFx?=
 =?iso-2022-jp?B?SFNjeloyMjBKc1ljdkYzMUZteDJEcjR1WUFpUFViOFpsZ1lTbkhNQUs1?=
 =?iso-2022-jp?B?bnI1NURTWnB3cUFNY292ZlNMOEJ0N2s3MFY3Z1Rxcm9QZjlxaVRNY0k5?=
 =?iso-2022-jp?B?QTIvSGlUZlA0K0VBeXBWZ0ZiSWg1akhocHc4MDFDdzJacm9jcENNSEhN?=
 =?iso-2022-jp?B?dEYrSkVRZ203T29Ibkk4azZiOGZqSDJkTHlkUFM0ZHhzaWd3RW9zdU52?=
 =?iso-2022-jp?B?Z09YYll5czZCRlJpaHZGRHZya3l2OXl4cFZUU2dPVlpUcmJXaUFUWDN5?=
 =?iso-2022-jp?B?VzlSV1ZDVDhzcHZMWnQ2TkVqMWN5dFZmeTEzZjZMQkhqMnhUYlQ2dW5V?=
 =?iso-2022-jp?B?NnY5N3IrMldTS3ZmazUvQ2Z2aDZPczBoYnpoRUc3VWkvdmlZZCs0Vmcx?=
 =?iso-2022-jp?B?eW5lK2VUVmtIcFZMdlpKdG5EK3RoVElmZUVmTUw1K2oyK2ZvUjU4WHFW?=
 =?iso-2022-jp?B?V1dFeEMxaXdvVDVmVU9yajczb0Z5cXA5cTdhd3dQQzRwMGExaGJJVmZI?=
 =?iso-2022-jp?B?dnVqWHhvMzhWSFBkdmZGZnc5UXJEQUc3eVhnN3dISkFmbER3WXZteHEy?=
 =?iso-2022-jp?B?TlVBclRWc2FESXhiNDN0WVRtaXRSaEVLZk1iN2RGZWtaMXpUQk10WUZa?=
 =?iso-2022-jp?B?UnQwYSt6ekU1bk9xUFByRThjTitEUDdSQ2xEQithMW5tQ1V2Sjk4WGd2?=
 =?iso-2022-jp?B?dng3SHdhUDBqbG8wd25jS0pIKytsS1doSURUQ3F2RFVmYnd1Tlc5WVJo?=
 =?iso-2022-jp?B?aWVDSEEwUjVicjg0dHZHbTRIOWZtTFRMTGNsb0tPUXc2MHl2Z1VueFhZ?=
 =?iso-2022-jp?B?L1o5NWRmZDl6eERNekNEZDlOVkNEcnJTclJHM1JrVGQ3b3RSVEMwaEFS?=
 =?iso-2022-jp?B?dzNOenRwcFFXdmoxTUh1RkhFU3ErSENUeG1sQXEvNGRSSkRRT1B4aUx0?=
 =?iso-2022-jp?B?ZVp1aFkybXNTUXIzREpnRmNwanFXdjhOSW0yTDBmcWlrbG5aaGNPSXAw?=
 =?iso-2022-jp?B?WDAwaWoyLy9JR25GSTJzNlRQNUxyMW4vL0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b78e45-4876-4373-062d-08ddfc2e5298
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 12:23:24.0354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pn6ixJznhoD7pmPWp9+lFbmZUsmbQrpHCpB3oSi9meU0vjoJJu3tRuOI2nrG3S1LnoreaPpjgbazEX7TkXEOtLMnsUYTv5BJWR6j0MCjuDKRJiEIIJx/WMifaHIEjat8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9586
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 12:23:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20137

Hi all,

CIP kernel team has released Linux kernel v6.12.48-cip9.
The linux-6.12.y-cip tree has been updated base version from v6.12.46 to v6=
.12.48.=09

Information about this release is as follows:

  v6.12.48-cip9:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      69fc69bc8e4642fb2acd38482bf6ab1739a3d1bb
    fixed CVEs:
      CVE-2025-40300: x86/vmscape: Enable the mitigation
      CVE-2025-39873: can: xilinx_can: xcan_write_frame(): fix use-after-fr=
ee of transmitted SKB
      CVE-2025-39885: ocfs2: fix recursive semaphore deadlock in fiemap cal=
l
      CVE-2025-39871: dmaengine: idxd: Remove improper idxd_free
      CVE-2025-39880: libceph: fix invalid accesses to ceph_connection_v1_i=
nfo
      CVE-2025-39876: net: fec: Fix possible NPD in fec_enet_phy_reset_afte=
r_clk_enable()
      CVE-2025-39877: mm/damon/sysfs: fix use-after-free in state_show()
      CVE-2025-39869: dmaengine: ti: edma: Fix memory allocation size for q=
ueue_priority_map
      CVE-2025-39882: drm/mediatek: fix potential OF node use-after-free
      CVE-2025-39883: mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(pa=
ge)) when unpoison memory
      CVE-2025-21751: net/mlx5: HWS, change error flow on matcher disconnec=
t
      CVE-2025-39881: kernfs: Fix UAF in polling when open file is released
      CVE-2025-39870: dmaengine: idxd: Fix double free in idxd_setup_wqs()
      CVE-2025-39886: bpf: Tell memcg to use allow_spinning=3Dfalse path in=
 bpf_timer_init()
      CVE-2025-39867: netfilter: nft_set_pipapo: fix null deref for empty s=
et
      CVE-2025-39884: btrfs: fix subvolume deletion lockup caused by inodes=
 xarray race
    added commits:
      CIP: Bump version suffix to -cip9 after merge from stable

Best regards,
  Nobuhiro


