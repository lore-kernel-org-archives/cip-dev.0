Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C897CA0EED
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 00:42:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.777.1755736958364821418
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 17:42:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=vYgzaWKF;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1755736955;x=1756946555;bh=6L4ZL8ktcfwRzLGo5hKTHr20YmYv8SDLFxesD
	5lkS6k=;b=vYgzaWKFWMuV5qT//wl0YWIFBjHqhWVVqtuvaENejBG8EKsyt32PiRcgoaa7LE8Lrbs
	xTYYC9BDbQUgkgpabNj/UK+Xu6Wz7sDvpiudHUbcKmuYd9lHdhFn9ssCiu3WBak6zASokSaMAM6J3
	IovW+lWAvvttboFPhaW6cJwd59dIRAiZ7wiTgc/j1COGjFbRO5TFNiUe3YengQd/6mO7VuXwLBEFa
	6TzdC+d0Kr4LpiSuAchCZIvFkWKTIcgQYVU4HuPfjZdTKWbtMPejd6WnX1ME1v9nHE+ZT+yGdCaJE
	9d1WpcM8ffGqM+wCapdpyHA9Ci14zMjfx65JQvjPej/A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 57L0gYsI2565452; Thu, 21 Aug 2025 09:42:34 +0900
X-Iguazu-Qid: 2rWhWAeBomvsm9GPu1
X-Iguazu-QSIG: v=2; s=0; t=1755736953; q=2rWhWAeBomvsm9GPu1; m=EbDgijrpqynSCpTTAjMK4g9173EPr2gYCblHLNzLARU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c6l093sfqz1xnc; Thu, 21 Aug 2025 09:42:33 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYXKAOs7P6Rgk86WzmDU3EbAhMuxlcj8LIOwtpAk5NMjcQuNWijjWwH9b1CCCxtOvPB3br6ffMbDbsnwVr9DM++TQBKjsYdrrsIIZ7YGGQtSiACjGzomEJEOG78kIFcqqxAitDymd3vBm1Z0LstwnJ8Ni69jxI9rT1l5Y++7OHimBbGkanY/fzRkJM/hXHtxW+EKWSm9+r0gLDmELmYUG8O9m2vOHsjWZ4EByMRwq1kVOeRZ3bh5bDGSt4hx5Xf4pniOjMyvXCNxP4qghdBgWfsbFdtt+ETC/LsuXsSNRNgPLNhBnQbbEaPxddonwWQgJdN3Fh5C+72spKoz8AH8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zav748hM/bmMjR0Xq9+oyDSqKfQnZsg7/+A+Pkdql8k=;
 b=LIoHdsouuxfZ2XPpT06zh9h2a4hRIkmqaiYejVYm1D1x3UDe0rOkgW5aPkId+UvVqF/E4mH9CkvzJtsdkhS9vCUVRsmUVnZU6FVNSuKotxEJostFWC/JdshdEU7luw6v/jf63TYxpiRJ0xIy4aTvVUI/BFwFoN4HPCeanHbSQyehyEnauUCW4Zi87AkjuON62ZPju81O/4DPEBtkv0e3Dcg1xpY/6B4NXyFVr04QPp1WC4UMkzXsvxEZtydVa8dwDtdfqA3BJE+2QmCNU0Au6iU0IL9CnOXoVbnMaFMZtiIaEYAySNxAYAUmqshELeyM+Yc6snSwZAYwrfEzVW0NNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <Chris.Paterson2@renesas.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <quirin.gylstorff@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro.hayashi.f74@mail.toshiba>,
        <jan.kiszka@siemens.com>
Subject: RE: Effective QEMU devices usage for testing in LAVA
Thread-Topic: Effective QEMU devices usage for testing in LAVA
Thread-Index: AdwNI0Zo7YnIbeRzQ4KMFrrfEXZpJAD5cXeQAErT4wA=
Date: Thu, 21 Aug 2025 00:42:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184147B7796D6C089E2079CD32A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB11075A93846FA70A1AEB01145C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TYYPR01MB151321574499D48D7E7119A7AB730A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB151321574499D48D7E7119A7AB730A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB13689:EE_
x-ms-office365-filtering-correlation-id: d1b51ed1-f8ca-42f4-2ddf-08dde04b9c41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UXNncnpJZzNtQXlTUmZSMk1DWFhORUtOdGlsQzZINU9tZEpoSnhZSW1a?=
 =?iso-2022-jp?B?bTlaaFV0V3NtSXFwbXZXVHJXeGZyZDFleDlmMkxPVWxHMTlHREJ3NWpJ?=
 =?iso-2022-jp?B?b3hSelZHbnNqdTloM2QzTlFRdFRlbDlRUmtTZ0QxRWNKeVVjTlpEQ3VU?=
 =?iso-2022-jp?B?Z1pxMHdGYy8zUUc5R2pXcVhweEZZSHkyZ3A1aWxRUGtOWjB2aGdFbDNx?=
 =?iso-2022-jp?B?aE92TnBkV3kvY0VteFFzdXFXZHhpUHUxanl0bHBGVXo2NUlUMk1GZ1VQ?=
 =?iso-2022-jp?B?OW1GSzZWQVJLam01K1dKYThGQXNTR0orNmh6a1JrSTJqV2NoOXQ4Wkxm?=
 =?iso-2022-jp?B?YXFZQkFCeGxVWTlzYkhKL0gyUDdFT2VkcWxnd2JvaytVd01tbWxvaEVw?=
 =?iso-2022-jp?B?am1IYnNXWWQzMEwrVWEvdWk2MlJCNEorR2JpQjFwRWdQb0hlZ2g3OVUr?=
 =?iso-2022-jp?B?R3lac1V1RGJiK2FoTE5DMCtKK2VzdEw1UVZ3SjVwbUc2MUt1dndzeUdm?=
 =?iso-2022-jp?B?eVhSQ3Yxb1haS2hvYnBWM3J5Y0FiQTJlQWRuSUMvcWxCMExYRW5GbmxQ?=
 =?iso-2022-jp?B?OG1zRGN4aUJIWW1HbnYzdFJRSGZWa1BkcFVLb0d4ZXlvTVR0Z1QrNXVG?=
 =?iso-2022-jp?B?NGJsaXZqQW1LY0l4K3pvZXIwOEUrUlkrbkxhYXh3VTloVTE0eDRndGhx?=
 =?iso-2022-jp?B?aDRKNStLVXlENGE0Ni9QQU1sK21KSkxWcmlBaGVNSm1pVHQ0US9nWjBG?=
 =?iso-2022-jp?B?S3VwNmZDRGdOM3hGa1pqa2QyME9lamd3QXZUcVBObkRQOVJqNEt6SDY5?=
 =?iso-2022-jp?B?ekZtT1N3YmZ2NFhMNVVHOWNJZkdzMUF2RUZYOWtiSXlvK3QrMUZESlZx?=
 =?iso-2022-jp?B?aEFmTEJTNDdmMzVyTWJrRnhpK1pydll3Rk95VWt5RkZsQkFURkRLdnd5?=
 =?iso-2022-jp?B?MzlRVmlOVXdEcFZwZHJNK2lFMk9VUGpRdFFyNXJtUVFJTjA4NldQRjFR?=
 =?iso-2022-jp?B?OUM1S2xyY1FDUysxMVFWVC9VZzFZMzh3QVdIUVZHRnBzdzA1Q21nWE91?=
 =?iso-2022-jp?B?a1lzRWRXZ2lMbGRMUkxKeVM4cS9HZG1leG80My8vdEpzcUhDVkIwRWNa?=
 =?iso-2022-jp?B?UFQwWDkwZEkxYVZJOC82cFM3SEtwaWg0RjFoRE43R1hhVEk4Q1FtZy8z?=
 =?iso-2022-jp?B?RSsvZ1JKdVBQZ3ZFMHo2NlpRZmNCZlhPRXNHb0JFV1A0dkcxZUF6dGtY?=
 =?iso-2022-jp?B?MnpZMnpZRmNUUElNbjVWbjdaUXZPWFV6cU9GWVcwMWh4RDREOFl6QlBZ?=
 =?iso-2022-jp?B?Z28vMFJPenM0eG9Wa3Y5TjhYOHRkZjFicXgrdWliZE1uWXl4Z2g3aHNM?=
 =?iso-2022-jp?B?c2N6ckVPdmdUTEVKV2V4a0labWt0aDNZbVRMVGZaNUJSUjAzWmpHTHZl?=
 =?iso-2022-jp?B?WGZ3MG5wZm95R1c4aFdWYzJHZ3QwZ0Yzc0E4TXJjd0pkOGxFWHliaGpD?=
 =?iso-2022-jp?B?WlhNNXQxMXR3dkdLQ0l2cEN6TERPc1ZQSlU4M2xLVXFldDE1b0RCMSt0?=
 =?iso-2022-jp?B?bGczMUgwYVpJL1BTRXRvRGtVRGNpYjdzZnFhZHE5VWE2MiszcVY0TXgr?=
 =?iso-2022-jp?B?UXh0MnI2WGRsTG5INzcxUFVXNkV5SEJ0cnhKWVRFU2VOaFM3UG1zaC9P?=
 =?iso-2022-jp?B?MGVZNmtIdW9uL2M5TnZjd09uZ3VybEd6MExUbG1tOWVaOVFYcUVDeU1h?=
 =?iso-2022-jp?B?MTZXWGJCcUdqTkVPaU9DYXhtQ3lacjJWUEd5NWEzVC81emJ1NlpJNVRj?=
 =?iso-2022-jp?B?dmZJYVJEMEROSnl2KzJJZ0NPT08wK0NwQ0dWS3FJcTdNRnFwdFpFQmFx?=
 =?iso-2022-jp?B?NUVOQmZQZG1JdWJhRklsc3FRQWhZNzViSUFpOHJYdW9uMmxIaDkyRVhM?=
 =?iso-2022-jp?B?RGpyMnZZVm9uMW9VOW5FU2NLcTA3WTRkcmt1S0ovZVFrN01hcmJiOFlS?=
 =?iso-2022-jp?B?RVVpUVgxMytzdmkvOWdieXFyZVNGb2dOUmptZTZBUC8yaXdjd2NtYkhs?=
 =?iso-2022-jp?B?UEI5WDRydHVZTUJ5UjhyOUZ0dDJZYW5ZZGhLY0lhL1p6aE1hd24va3d6?=
 =?iso-2022-jp?B?d2NncTd4eEwzQVFLRUZyZ2pvSkl3dzdBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZDgxZUw1dFArT1MzaGFpOXY0OHMzWGdJUU44K1QvQmJ5aWs2Q1UxaEh4?=
 =?iso-2022-jp?B?R1NOSkdvMy8zTkh6NWdqZkhVSy9maEdVN1lYUlZXc3JEaUhLaGJEbTd6?=
 =?iso-2022-jp?B?cDVVczlENXBpWnNqQ21aNEZOdVk4eVRiWnRuTTQrOUhoWHRUbEFML3Ar?=
 =?iso-2022-jp?B?emxBMEgrbU4yTTlyNmFMZEo5V3dFc0dlMktCNCtwUHB3Smx3UlNiQ2JM?=
 =?iso-2022-jp?B?VCszeGZTVHhraFJWRytZVmFqWnBOYVFPVUZUQnR3ZUVUOGdUOXNmREtO?=
 =?iso-2022-jp?B?NkVBdFNLMk9HRnptUkdSUzlzMlY2YzQzTWxOY2Ztc0NZWEs0MkQ5ZFNZ?=
 =?iso-2022-jp?B?cHJrNnYyK2FRNEZadmhxVVV0amxpdnV3MUliUGs5ZHJuWWxCdGwyeWF6?=
 =?iso-2022-jp?B?di9QZmt4ZGg2QnU4RlNjdnNxb1RjM0VHQmtDT2lGNUtSY1RIbGFoWXJz?=
 =?iso-2022-jp?B?alFoNUp1RTZNcWpNdDViRXRKR3lKOW1Pdkk5L1NiWDdmWmNLVzdCU1lx?=
 =?iso-2022-jp?B?OEdUMFU1V3hCV2lRZFkxOXNYd0MvQ1EzeXpkamFJc2pxUkFpRFkrYWxV?=
 =?iso-2022-jp?B?bk01WC92YVBkRllYVGc0OG9HVW55dFNmWGZ4VngxKzJtd1d1elJjVllo?=
 =?iso-2022-jp?B?WUtWYnhiRzN2Ylp3d25sOVZ3WXdUYndmVWxzaG4yMDdKbGRVNEpnMEp6?=
 =?iso-2022-jp?B?YzcycjRBV3VsclAxeEJ2OWwrZFJqWW8yb3NzalI3cGRWN3M2MWN2TnhQ?=
 =?iso-2022-jp?B?OExaS0VrMUtzbkVVYTJEN2Q4RmQ4RU1vR2p6aE5DMkkva1BSZTdweXhO?=
 =?iso-2022-jp?B?RUNXang0ZjAwNW5Kbk45ejVFMnJIcDJOUll6STYvTjNoVUdBNHVnZ1Ar?=
 =?iso-2022-jp?B?cXczRWFyenUrU2JjczU4cG1aR1UwMWlFUEpmZzh2aFBiYnZtekRYaTNM?=
 =?iso-2022-jp?B?R1FWM0hvcGwya2plTVZ5RWljSmErTmlhM1c4UnFCM2hMbzdlZUdaTmpp?=
 =?iso-2022-jp?B?d0Ntbyt2eFIvK3k5Z0RNZEFJSEFVSTREOEo4MHFaeUFVWGkwNXhJRFo1?=
 =?iso-2022-jp?B?SXRZcTk1c2hZTlhiVkF5QUhGcnRncnU4QXpxa1lpOHRXb3A3WTRjVGlB?=
 =?iso-2022-jp?B?dEZ4WTdVY3VRa3hBNjJjWWZsVTVoZThaYkpiWWZ2RkR5T2Q1YUpHYlE1?=
 =?iso-2022-jp?B?NTBRL3U5MmhvakRHeTVsZG9rSnpabDBIOUdGUllxVTZ2b1ZScHJ4QXhY?=
 =?iso-2022-jp?B?MkNEcDN2Skp1Y3cvTmRjM3VvdXd3dC8yckxLek80a0IrdTlPZytERHcw?=
 =?iso-2022-jp?B?eEYrT0NKb1dZYVBKOHBDWUxKV2J6aDhVdzVOSnFRWnd3R1hON29MUnAz?=
 =?iso-2022-jp?B?S2JUV0V4amdPKzdxWW1yODVIZUJqMnk1dE1XL3dWMlBQdkRWOERJbUxN?=
 =?iso-2022-jp?B?ampTdytIZkx2dXBicWFWQ1JMYUwrdFI4TWhBWkpTNURySGZwV2dCbHlk?=
 =?iso-2022-jp?B?MlpWalhnSUtlaFhQL0lMWWtTTDdnZEIybjJzbUlwME41MEN6bitmMm1h?=
 =?iso-2022-jp?B?NzRTTFRYVFRzNmx6VFl2RTJjWnZHTG5JT2NBYS9kTkxkMTB4blZhMVlF?=
 =?iso-2022-jp?B?bFlEYjMvVzZpY0FIcENiYjhMK3FWdXZyY3NRRVZubWtsU3pCSlpYMzhx?=
 =?iso-2022-jp?B?NjMvdWdUaHBlcXpoY3VrcjY4SDRMVk5zSGNVdjM2K0w4Z3pEaXI3NzZD?=
 =?iso-2022-jp?B?Yitkc245dWVOMjZtemJJS1cwa0xFOS9adWRLQUpqbUFnKzE0NFNiWndp?=
 =?iso-2022-jp?B?bWpIek1nUzlEeFFMc040QkFueFducmtPcmt5d0F0MDZpdFZNcm04T0Fi?=
 =?iso-2022-jp?B?U3dybUdtVGdickoyZVVJZURTWmlxZFBUNDNGM2IxUlVTeDZuei82dTc1?=
 =?iso-2022-jp?B?dWQ4d1dLa0hQMWZVQlB2MUd2dFdHRTBjektHOFFCazdvT3ljbkZqdEZZ?=
 =?iso-2022-jp?B?YlY4WHRHNlY4RUhUcHFFV2xNb0VqMm1UVVpxclhYam9pZDZydnZJazUx?=
 =?iso-2022-jp?B?emR6M25RbmNHN1FvN2JpUUtCWjNNaUp5TTQ0ZXRlVTZMRDN6K1BHMTg1?=
 =?iso-2022-jp?B?ekp2alVZWDNCOUtPVXlFd3VHU29XUXY2RlhzSDJPQU03T3JZZHMreFZS?=
 =?iso-2022-jp?B?c3F6Y0h6QnVPN3N4eDUwTFRZWHM1bVE0Tnp5eGUvSUdSNjBOa1E3a3NC?=
 =?iso-2022-jp?B?eGZsZlFvVDNqdU9Pd3RrREFPMU9wcW9NV1N0VldtTW1BOVV3WjBjS3FC?=
 =?iso-2022-jp?B?YmIxU0daNFFTSkJEaW15dldEQWQzR2ViNXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b51ed1-f8ca-42f4-2ddf-08dde04b9c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 00:42:30.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBFW6iwnR/1MX/Y1IjAnBcODbzQzH/QPZTarYJk4B1KdXX5HQtWRKSZ0IjXXi+qXTEqTBJsPlbpn6U+NmabfN5lYMel64TIVqgWpwXDjoRbBLV6sqFt33SG9jS/5gv5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13689
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 00:42:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19927

Hi Chris,

> -----Original Message-----
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Tuesday, August 19, 2025 10:09 PM
> To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST)
> <Shivanand.Kunijadar@toshiba-tsip.com>; Quirin Gylstorff
> <quirin.gylstorff@siemens.com>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.M=
N=1B(B =1B$B""#D#I#T#C=1B(B
> =1B$B!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9=
(=1B(B =1B$B""#D#I#T#C!{#C#P=1B(B
> =1B$B#T=1B(B) <kazuhiro.hayashi.f74@mail.toshiba>; jan.kiszka@siemens.com
> Subject: RE: Effective QEMU devices usage for testing in LAVA
>=20
> Hello Shivanand,
>=20
>=20
>=20
> I=1B$B!G=1B(Bve enabled these tags and the required user_commands for
> qemu-patersonc-02.
>=20
>=20
>=20
> @Quirin Gylstorff <mailto:quirin.gylstorff@siemens.com> ,
> @nobuhiro.iwamatsu.x90@mail.toshiba
> <mailto:nobuhiro.iwamatsu.x90@mail.toshiba>  please could you do the
> same for lab-cip-siemens-prag, lab-cip-siemens-muc and lab-iwamatsu?
>=20

OK, I will update my lab.

Best regards,
  Nobuhiro



