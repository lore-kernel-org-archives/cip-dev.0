Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A2DC83F17
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 14:03:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.9508.1752588212200464440
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 07:03:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=AzzyazIS;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752588176;x=1753797776;bh=7yHx8hZBGD6ifMeNL3CV4IJBPuKph4//x9dE14K
	rfb4=;b=AzzyazIS1XH8cMJ60t+t1YTAZDt+x4ThUJ+pwJgmfYx21Q8Z9oK1JbSemeHBwT7fKVMNH
	5s9W0/6Buns/oeArGeY4ErsARuWS/v1PlDLH5n3hQZPone2wfu4lZD8vo6/LcFfk7gJCeqj+iA9M3
	il9a3kVdOPI6QWHmGaILF4ZOUMIuLkEkRhGTD7Cue6FdQvR4/EA0VtZO4E6F4I6LFDcwuhdTMqZLV
	wWsWclFgeX5Lu7SpbcYGvwxXZt2ikh7y+vZKYx6aeu3yNkq2P6tuGoz4B9e1NF62fJNspJJMQJs7M
	OAFo1hoKckKbfvVeMmhdV4qUTRIslo+MmDzk6kH4uw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 56FE2tYl1862872; Tue, 15 Jul 2025 23:02:55 +0900
X-Iguazu-Qid: 2yAbaKzOk5m7aoLamO
X-Iguazu-QSIG: v=2; s=0; t=1752588175; q=2yAbaKzOk5m7aoLamO; m=IBD/hGklJq+9Nys90K4ew0M7tRg+IeMyUYRZGsNuXGE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 56FE2ro23504159
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 23:02:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPV0ZuXOzM10eMByIhVy/eEPRuDu4F1h7o+qRCBmoa1E2KEh5Nyjr7Bs3Z3Yd4AnQ05kck/0otELDeJz7GTgnutPnKqs238/HrmbWJipgKDMEr9Bequ/EujDyYJzceAlaot75y5Zjzf1ecpdoVetOM4hNuRyyoNKrhCNhYswsmKk+w3GC2tcDYoWDpScdYBGE5w1IK7DCg7qikeSs55fQLYXh5OnzF2b98xH2abfW+aFiESgu3QeWCuuhHPD8lUlb+w41CLFR2hPHOIBmkOxmIiEQdm6hx/YB0+0OaeDZnLqT44XVAixJxlcNOqkLv0MGtMEGUug8H8e7rxYaPKfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yHx8hZBGD6ifMeNL3CV4IJBPuKph4//x9dE14Krfb4=;
 b=Ll64rJ69c8rXlXcxHluTF656XEiloQ3zEUtIA6mFuwcQ5iuu929GmnZiErzJMde1EajqR8E+xJ9YANCHFhzQn3mu6Jb6BnI3DEkVENVf0wd4YzPs0U+4+dnNRlqmRmBRCHPw7wE2OsCk1dHOjRgKlxPPMMFgaqlhgZZ7GiVV11t1EmPIQbFEdY9f6AlBqYmuYECYcFnaopgUGOcXlchQN/aipDuZI9R2SdKVWz6WKetUGBQqS8kJksRVijPLeucQPes+bhuPJQG++tNRQ5xODa9iVgUdefZJKHbn/h9RlbrvGNgCV7+Nw6jBFYCwCwHvpIrEx8V38pga8eBYf5Z8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>, <uli@fpond.eu>
Subject: RE: [cip-dev] [ANNOUNCE] Release v6.1.145-cip44
Thread-Topic: [cip-dev] [ANNOUNCE] Release v6.1.145-cip44
Thread-Index: Adv1Xy1UoXCELFAwR9m2r1kNXnVaDAALny+AAADOEfA=
Date: Tue, 15 Jul 2025 14:02:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189F17388801D22C715E0C9257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <TY7PR01MB1481892C3F332A8DD99DBE2989257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <be2c98b1-61de-43ef-b86d-63a17ee578b0@siemens.com>
In-Reply-To: <be2c98b1-61de-43ef-b86d-63a17ee578b0@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB6630:EE_
x-ms-office365-filtering-correlation-id: 1e721385-7df6-47fb-9366-08ddc3a8498c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OStPT21EdzQxeDFTTEs1anlxcGhFdS85UG9PTSsxUnJJOElNRk9hZmZKeE5P?=
 =?utf-8?B?RlBrSFFCU0F1dHlNSWxjYzIvK3FJRVVTYzMxNXprSGJPaUR0ZTdJdW5RbW9F?=
 =?utf-8?B?SDBtQXRleEdmcTc0WEZud0g4dGcyM3pqd3ZuMWxZR3ZDWmcva0M4R0llQ3BV?=
 =?utf-8?B?dDBLZVk3aGxzY0ZYVmZPYkw1RXNUZzlHelMwS1kxWTFic0NNaWtXTGNvNnpJ?=
 =?utf-8?B?RXZPVmxub3FFVGZ5VnJNZHZlUUJGUTczSmpCMGRBYlZzaElQZm9FTW9UTXIy?=
 =?utf-8?B?dUc3VDYvM2IvVGdLM2JxdHpDZFRiWkhmUjZMSDI2WHQ1Vmsza2NTOWRNMk9s?=
 =?utf-8?B?ZGpvREdnYmxyWm45aGxtSE5ua0hDVkczZExKYmF3Q0RQRS80L2FGZG9TV2Jy?=
 =?utf-8?B?NXlqN3B1akhTMnBINXgzOWtjODRCdERPOGptU1NYbGVSU201ZEFzOU5FT2RI?=
 =?utf-8?B?MFhDTHZWdU50Ny90RlNpTG55ejZWYS9VdmZnN1VWUFhRcElqQVIvUzdCZnhR?=
 =?utf-8?B?R1ZqYzEzbjhDMU85VE5zaWhNMzhzWHFZS3ZsUUxPZUZsT0JzQ01jKzNZVTRW?=
 =?utf-8?B?NERGdjJMa3JVd2NVa0s5eC9YY09jVk10RUl0eDl4eFUvOTdNTkh4cVR2eFdI?=
 =?utf-8?B?OHR5eFk2RmUvcHo2L1JMVUloMEYxeUk4WE0ra1VIcjJvTXV1Z3UyWEJ2RWcz?=
 =?utf-8?B?SGZjMFlpT2FYUTBmNWI3emFlbjlKOWVIbys0aUtDYjlvY3FwNGMwckl2RTJi?=
 =?utf-8?B?ZmpLMUNvQmtwQzhNZ3krajdSYmhyRWRaV2JZN3d2NngyNVhmTmNSSXFyemVU?=
 =?utf-8?B?Z0ZGMGRDazZ4bVcvR00yQVVrRUtOYnZvbUZ5S29ZWEkwWUFqWVVSR3pqMzVa?=
 =?utf-8?B?UjFzSzJQTkxFOGd0VHl4ZkFiWXhISjJWUFk5T0plTnV5a0Z3d2pza3dMOEtt?=
 =?utf-8?B?OTVUU3VLQXdmSGdlaG1LRVR6MXI0N0ZUdUVyUkZ3a2VySW9CRVhOeUxYdWRy?=
 =?utf-8?B?bXRUZjNOaW4wYlR5V05lekhJaSs0cVBHTkphdFAvTTVKL0xWRmplc2Z2NUth?=
 =?utf-8?B?NFBscFcyQXgycVE5dWlCOGxEUW0zUC9PUzFFWjhsOXdxYnp3dG45LzdWTTRn?=
 =?utf-8?B?aHltdmhRYWpYY3NkdlV5U2hsQ1R5WjZFcTVUZk02UXBqVG5uT1l5SGY5VE5u?=
 =?utf-8?B?WkEvRVQ3ZzlzbEo1UzhPQ21jZzl4cTJkS0xLNDcvaXRPU3dJYldvaEtMc0lN?=
 =?utf-8?B?T1c1ZkI0WS9BTW1naDAvbnEwSldxK0FOb0Z1SG5SbTVHMlZpbEg5MWZQNzlL?=
 =?utf-8?B?am0yUTRtTFdmeDQyTG5nbUVxbG9PWm5FNEVKeFpRUmF4VWcwbHQwNHRTV0xq?=
 =?utf-8?B?eVRRNldoSGl3MFY0Ym1tZzhmaWVYbkxRTnRNVkFTRWFWcnl5cVpuQml5R3Q5?=
 =?utf-8?B?WlFnZmNyU01kaHhYc0VKaEZjc0daM01hSjZUYU05ejFrMGNiK3V1eUx0WjlB?=
 =?utf-8?B?MzNRbktsOWl5S09IL0dYUDlvSVR6V3hjRlRKUWRpbEk4ODdKU2FJZVZPeXpa?=
 =?utf-8?B?R2dObk4rUThHUmFEYklvTzZXTFpyWDlMU2pheU4zb3ZETTBISUp3R0NXTlRC?=
 =?utf-8?B?Zzc2OERhMjJtL0N0WGcxRG1McWhYM3hieVJFY3dySWxjRGZ0dkhzRTI0YjZC?=
 =?utf-8?B?YldaYVYwYUFzSUZHQTM2RitoZHNDbmU4YkFuc2IvdFpsM0ZwUlA4cGt0RUFQ?=
 =?utf-8?B?VXN0VFZzZmhLbk9kZFlSRFZpZlc5ZW1MUkF1MVVOTGVES3VwMnhKQWlLQXZl?=
 =?utf-8?B?RGFReFJZYVhMMHU5SFc0bUFienlLVVJVdXNzNGpNdkk2RzhKVmF5Y0dtSDRI?=
 =?utf-8?B?ZGtlZmZRakwrdUJ1eG5MYkdrZEJ4NGxVTmNQb0VxZDVTUkRRU2tGTXRyOVh4?=
 =?utf-8?B?elV3b1d2M0xacmg5bktNRkVCUmRTTzVMK1BCcTNTQkZBNmVoV2I0QkxIK2M2?=
 =?utf-8?B?UXExd0dGMXNRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TDltNkRvZDRJMWRoSHV2d3dkMGo3V2RWaldsSjZGSjU4citueWEwZ2JVZ29h?=
 =?utf-8?B?MUJOTTJXZ2tXU05LL2ZGaXlscVY2N21WMDhjNHJNOGJpTC9zcDVJVVZxVHVy?=
 =?utf-8?B?TEp4UFFRK3FFeGZvVk1BcG9lNGVxNXZvVGM4Znp5T2lMeXEvVzJhd1RRUlox?=
 =?utf-8?B?djFOS2pYYXlDM2g1TENpaC9VY0lKTFcxR21Ca0ZYbFRoaThlMFNxM2pIeDBu?=
 =?utf-8?B?WHZqTGlZMUVUSW5EcnlqamlqMFVCWUQ5cnE1SFA4YUpSSml5Zy9SdTR6NXhF?=
 =?utf-8?B?andyWnJVY0FhcXc3QWYzeEEwZlNJQ1NoMDNIcHJyU1pFUHpsdStyc2YrZElS?=
 =?utf-8?B?bGpHbXhWTldpelUzTTZLVmt5djR1Szc1OHJNalRnWWhCcExLQlJld1REVnBV?=
 =?utf-8?B?Q0JndlVPS0J2MkVIYzdteFdBOVhrRTJ2VkdUTWdRTFUzT0FTMDR4bGlzNlFK?=
 =?utf-8?B?SXQ3SEN2UVJKZVpjTy9RZEgvd0g0N1BpYjBkd0tCc21NUDAzUTI3dkNhUW1O?=
 =?utf-8?B?bW0zenluUmY5ZUhSZnpMTnhoREpsbmZVdDBsTC9qQjlZZ2sxVFk1ekhKTDNZ?=
 =?utf-8?B?V0ovd3hmVWhHWUcxNnpMSzFVWmd4c3h5YnVPZjQ3QkdDaktWNTROUkdIV3A0?=
 =?utf-8?B?M0s2Q2RjZk04eDhyVkwzVXBBWlkzd3RaMGw0c29iSFJQakp5bTE3Q3BaZjZy?=
 =?utf-8?B?Z1dMMGc5aGlTZ2hLaHF2WVBnYXcxdkhqQ2I4ekFyRmdaeEp6Y3hndTc5c29u?=
 =?utf-8?B?WHI2bHZ5R2xtc2FiL1E0QlRMRGxQZzBvZFhQSzZvS01zMUV5YUl1SmdhaWlG?=
 =?utf-8?B?SUxRMWJhdjBuVkduV1BMYzVzSStNWXVKY2hPbDRCMjRON2Z3V3NBaWZIM2Zh?=
 =?utf-8?B?eHA2eWZ0aitjVkhZc2ZPYS84Z1pZQ0dIbjloUmNMTkxoMFFlNjVaSHZ5algv?=
 =?utf-8?B?VjNuUURocTU0VDd0T3N4bEMrRlMxRlhxREJLbnpPR2JLUUppRVlpMjJGcWlF?=
 =?utf-8?B?WlBoaW93OFY0QmRpcVAyNVArWVFhaE1RT3pVNmRpT0ZJd3RlazB4djhwVzhy?=
 =?utf-8?B?eUI3RzVoYmRlQ0U1Q2tyUS9uOWNEb09aTFAvS2pHUTh2VkduTVNjUzRXU1Nr?=
 =?utf-8?B?Q05yT3FWV0xVR2lSOWhFWC9ZcEtDcVdEMDhzZTNKblUzZ2ZRcUJBSHVrajJx?=
 =?utf-8?B?V2UvU21Hd1diZVpVMkZ4VUNtUWRHTEREL3pLckg3SkhCZVUvRm9mcHplMFNp?=
 =?utf-8?B?dGZxL3RyMHZHdEc4cnJ6ZDFqS05DSys4VUxkZzRXb2tjbVFIMWJvUkg4L09o?=
 =?utf-8?B?THg2bm02OE9JOFhYYXBseTVvQno3Z1JJVXdHQTRsNUp5cDJXV3cwblF6YVRY?=
 =?utf-8?B?Y05XN0ZIUWRXUzBVYmlkcml1b1BhdEE3SWY3SlFyOFRLTTUzSHpJd2lDVEZ3?=
 =?utf-8?B?eHNCQkcweUhIMU9EUHI4VVBOTHZFVjJwOXNVc2VwYlBFQkNIVlluanlpdSts?=
 =?utf-8?B?ZXJrdmkzWlErakxwWXBjdnY2Q0k4ZTVmWWdHSkJVQm9LeXJjaG41YzB0d0Ix?=
 =?utf-8?B?cGdwSnp2bGF4M3UvcWV2djJLYnVhdXNoa3JRYTBpN3FGNENJZFBhRDdiNmdC?=
 =?utf-8?B?eWFocnMyZGdOTkRjd3JiV2VFeTkrY3RxUENyWFAwdkhqenZ1MTRCWnlYS2ho?=
 =?utf-8?B?My95NDNZSnNYb0VkbkZWQWFydlR2UGhzSzFpOUhCQnBTM29oTFEvVkhMWFhk?=
 =?utf-8?B?QTR4VUxzek1zN1RveUJKQWpzUHV1cUVnR3doS1NFbGhLNkVidGRPT1YzKzE0?=
 =?utf-8?B?NWNkanhmWHpyR0tTYXMwUkJNYnh2NFNGTWd3Q0JTUEhRblIxNVl5S1Zpc2ZB?=
 =?utf-8?B?NGpkbVdqaUlsWXhCejNtM2d4bkkwRnAzOXVXQnpiWk81R254a2FuVFNrbEti?=
 =?utf-8?B?VHUyVDVoOEVuUmNWUHRrMDNPc1IrV1lRbnBNSTlnMURCV3JnYnlRRkRaWGNX?=
 =?utf-8?B?Q2FqdDNRTnBUc3ZZMUsvUzhjT1prQzYxWkM5TmdYbHR6SWVWZllFTXJNMkpl?=
 =?utf-8?B?NWxYbkszU0cwTHpHTTZiUUdBbGNnSjNGRVlHclFjVDd6ZEdoOVhEVEJta3FP?=
 =?utf-8?B?MHBNdE5oQWFqVmtPZC9KWVdNOThmejNwZHhmVU1CMHRtZEYvMjY2RGZRUTdF?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e721385-7df6-47fb-9366-08ddc3a8498c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 14:02:51.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEFWHujQXvHBJFEAppastAY0NUU/Dk7vFanpPfglFvfhOIa50r+lL96saJDN9VvOfuu0KWyaXAET3ZEs2cn+0NHk8+xxlM+bS9GX4yAyxGF0fDJBTddpk5BiH3wz8ABm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 14:03:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19542

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiBUdWVzZGF5LCBKdWx5IDE1LCAyMDI1IDEwOjM4IFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGly
byjlsqnmnb4g5L+h5rSLIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkNCj4gPG5vYnVoaXJv
MS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
Cj4gQ2M6IHBhdmVsQGRlbnguZGU7IG1hc2FtaS5pY2hpa2F3YUBjeWJlcnRydXN0LmNvLmpwOw0K
PiBjaHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb207IHVsaUBmcG9uZC5ldQ0KPiBTdWJqZWN0OiBS
ZTogW2NpcC1kZXZdIFtBTk5PVU5DRV0gUmVsZWFzZSB2Ni4xLjE0NS1jaXA0NA0KPiANCj4gT24g
MTUuMDcuMjUgMTA6MDYsIG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIHdyb3RlOg0K
PiA+IEhpIGFsbCwNCj4gPg0KPiA+IENJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgg
a2VybmVsIHY2LjEuMTQ1LWNpcDQ0Lg0KPiA+IFRoZSBsaW51eC02LjEueS1jaXAgdHJlZSBoYXMg
YmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBmcm9tIHY2LjEuMTQxIHRvDQo+IHY2LjEuMTQ1Lg0K
PiA+IFRoaXMgcmVsZWFzZSBhZGRlZCB1cGRhdGVzIGZvciBpaW8sIGNsb2NrLCBtbWMsIGlycWNo
aXAsIGFuZCBkcm0gb24gUmVuZXNhcw0KPiBBUk02NCBTb0NzLg0KPiA+DQo+ID4gSW5mb3JtYXRp
b24gYWJvdXQgdGhpcyByZWxlYXNlIGlzIGFzIGZvbGxvd3M6DQo+ID4NCj4gPiAgIHY2LjEuMTQ1
LWNpcDQ0Og0KPiA+ICAgICByZXBvc2l0b3J5Og0KPiA+DQo+ID4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCj4gDQo+IElz
IHRoZXJlIGFuIGluZnJhc3RydWN0dXJlIGhpY2t1cD8gSSdtIG5vdCB5ZXQgZmluZGluZyB0aGUg
dGFyYmFsbCBvbg0KPiBodHRwczovL2Nkbi5rZXJuZWwub3JnL3B1Yi9saW51eC9rZXJuZWwvcHJv
amVjdHMvY2lwLzYuMS8NCg0KU29ycnkgLCBJIGZvcmdvdCBpdC4gSSByYW4gdGhlIGNyZWF0aW5n
IHByb2dyYW0uDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


