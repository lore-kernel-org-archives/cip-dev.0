Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F0E69E9D
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 10:15:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.16043.1733220917284476046
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Dec 2024 02:15:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4B3AFEcE682668; Tue, 3 Dec 2024 19:15:14 +0900
X-Iguazu-Qid: 2yAamusivEtB1wLZce
X-Iguazu-QSIG: v=2; s=0; t=1733220914; q=2yAamusivEtB1wLZce; m=ihSQ8YUxCx2KNEnrYL826SpPm3yE+XB20A+pAz68gr0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4B3AFDfm3938913
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 19:15:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be0OZyrXGJ+HE/Jws5xJfKh38HYD000qsekKwI0kZ0VJ+C77dkXhXiwN5xflmP5ASeQHAonnXbMJBQNUWqxL32LAOQ610YLna2+sqwWeQnvMbZA0pPA/5ykKXy3nOgpLySoXr+RWVCJqKMBIHFqU7Y5Qs2zE5qKpZYprFStIEZ1s+VVI0zLrbBsOg0D7rFzUeUvzaw4iSQL2AdVHE2owPRP467mxfrRDoDEaB+5IggXVExPzL5IVxE7OC7Zut8B2MI0czTSHB/lGKLC/30GMn+u0gcSx4SDK6GqIBqY5tn81ayrto+SdYmGwPrHjy5rxLrAsXN8+JZTbImdPuGh5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdJccmign5jyx8tXJcbeYgekTDdXz5ZqWukRT4TDddM=;
 b=b2RaU/9zUgvtKzj7xvPBFbG3iu5RagUez5KF0/Wx3xLf9AIOwkzxcSK8mErwJZinYCZEa965kcth45+zbavdJoyNIdLAMO51c/hDkO/4GE+aRaFXfOfS7tkIz+zpL9iHcUwC1gIIazpbFsbLgw86+4HvMQvTNSf2oBeoGurD6E098bUmYWJCdYlvSYb8sMWHHAbTQfpwaw+P0Ay6EWfIyrBQxKlKMJrTprUSBuy2k5SkE8PnkL4aVYu/TjXmAMvTAZFMgtEmLOuHDQJQb+n7iaziM7BMsmth1mwey64zRUpHm2wwgxPOrKN7gTKlrVVDVTqj++cgiq5mbDxSbLmCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <quirin.gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
Thread-Topic: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
Thread-Index: 
 AQHbQLwTUaTAYoFsNEu+W9FEgwfyArLLKo2AgAfBa0mAAA2vgIAAAafRgAACPACAAVjW6w==
Date: Tue, 3 Dec 2024 10:15:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103FAAA91FF871B95C6B9F7C2362@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <434bc0cc-a0b6-4095-834c-ddd6a3fb2b09@siemens.com>
 <OS0PR01MB6100E150797AAB51AD72A3B9C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
 <15dbcfce-757a-46d5-9d08-d4a8298348fb@siemens.com>
 <OS0PR01MB6100597A316A2139498736C6C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
 <b23ea3ed-d394-4ff9-bed0-61d4c6257971@siemens.com>
In-Reply-To: <b23ea3ed-d394-4ff9-bed0-61d4c6257971@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OSZPR01MB8058:EE_
x-ms-office365-filtering-correlation-id: e5ae7d85-c02e-4a69-b822-08dd13835ebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?T1ZwdXNGQVRFN1lsVE9kVzBXZ0dJQWZlMExwT0JDeHMrSXBhVUdxK3ln?=
 =?iso-2022-jp?B?bDhuWXo5ODBxVkZHeXZhS2M5OGwxRzN3dkxYL0RWSzNCK2ViNUdtbUY1?=
 =?iso-2022-jp?B?Sm5CejBGcjNIY3VnK3JsSndVZHJ3T0Z1Qy81cW5FMzljYWNIME13MEdO?=
 =?iso-2022-jp?B?VmYybjJtZTFxdFdUekpvU1htSnRZOWM0UTVWcHpXczY4elhackNWUEJL?=
 =?iso-2022-jp?B?dUMrZXkyTHpCNEQxUy8zQWtwVlVER1JEOC9DdEgvVnVRcFBvUU1rS3dF?=
 =?iso-2022-jp?B?cWN3NkFVNnhwMGJpeWtPcHpmUUxLcXd1Qkw1UTZPQWxrUUVsbDh3MFZm?=
 =?iso-2022-jp?B?cnEzZllrMHRoWFgwMmttLzNacTg3TitsTDRWZ2pTMFA0QVBuYTIzczEw?=
 =?iso-2022-jp?B?TWp1OU52S0xrUEJ3M3RmRkp3Sk0yclVkL1paKzZ1NnEyWW52QUZqdW9m?=
 =?iso-2022-jp?B?SkdKVUpqUWdSV1dNV0FVbldxSnZWWS9OMWU1dFN4S280dGZveGpSZTlI?=
 =?iso-2022-jp?B?L0JEYSsrWjB5RWg0RGZTWHBtWStNTnptaXp3QWJrSmFlcTJZaWpTZmQ5?=
 =?iso-2022-jp?B?TDJtVjJySjA0SGZLbDJYUzNBZ0QxY3praFZmSjM0Q2lPVjI4YWE3RXkr?=
 =?iso-2022-jp?B?WWdOUlh2Z2FpSjhJWFZBRzB3dDNnUzdhK3YyMnJCcGZMZ2xVbjcrbFlJ?=
 =?iso-2022-jp?B?QXI1SUZ2UXhQQ2lGWXZ4QkhLeEJqMWNLUXJpd3I3QnVCR2FwRzhNMHNx?=
 =?iso-2022-jp?B?T25tM0F2Y2RzRlNRQ0ZOVTVvdzVaOURWRTFiUDFpY1VOOXlNbFlwMmlM?=
 =?iso-2022-jp?B?dkxiZkY1Q3pVbXNRMWwycnZ4c1NWZ0FPWDQ0SVJxUmc4Y0piUmJzendk?=
 =?iso-2022-jp?B?WFRxWG8xZG1XdmZlM3htNzFWS2lxdm5FWXYrRDBNOWNsRDFuYjlVQWNt?=
 =?iso-2022-jp?B?aXpRdmZTZVluMjVsZHV5a1R0dHVqUFBKNklnYUVwT2ZCN1RXQ0MwbFl3?=
 =?iso-2022-jp?B?aEZaVGo3RTkyL1pNajdTR0xYRk11QjFkK0RrelhKTDZMcFd3eTVIODhX?=
 =?iso-2022-jp?B?cGVTZ25XMTQrTVNGSlI1STRrN3NCNTRzZHJ5Qkgxd2k2NzU5TG9JYXFn?=
 =?iso-2022-jp?B?TGpSS1pDZGpBUmNLcVF1UXUwZFhTUlZMODRneHBLYmorVkhtZnEvTHZm?=
 =?iso-2022-jp?B?NzZQa2F1MWp1QkpxY2hHYnVDY2ZwTEkxR0JGOVNEWTZEand0ZGsvKyt3?=
 =?iso-2022-jp?B?Tnowa3RuYUJwaUJmRm1Gb29yN29QY2l0UFB4cStVNGsxeXZMN2lTb1h5?=
 =?iso-2022-jp?B?QzNmeTBoaS82T3RhUmxVRzZ2NnZUZU1YUStsaHJnVlBuRFFldjBKWVgx?=
 =?iso-2022-jp?B?MlpJTHZSWXRETFdPYnV2NDVSUTl4ai9GWGdtWTUyalFOQ0p3QWYzV2pn?=
 =?iso-2022-jp?B?MDZKQjBjNE9VcUhObFFsOFFoQnhIT0VwTXRnWllSRGZndzhPYlQzaGNF?=
 =?iso-2022-jp?B?MVMxOUo4NVdXN3lCN3puUC9XbmkvemtKbDV1TFV6cHh3UVk3R3FiNGY2?=
 =?iso-2022-jp?B?UTFaeURuWGR6TGgvUnVRRkFpZnhaeStPcW81NHFNL1I3YndabkxpaVNj?=
 =?iso-2022-jp?B?ODBrQTVsL1lDK29OLzNDbTBlVEJsVVY1ZWl2Z3p3MXFEWk9Cc1RoQ0tx?=
 =?iso-2022-jp?B?NVJ6TWc2VTdkWVNnKzM4ZDVKNGRjWUViekV4dTFKczNmRGtyK3ZwNW1R?=
 =?iso-2022-jp?B?NzdZS0RWdTMvdWpHYUQwd3NQeCthY0p6RkpkWDZ2R3RwRjZiSTlPNEhq?=
 =?iso-2022-jp?B?d2N5YnJtVkNZdnN2OEdlM2thSTlyd0RZU1pTWlY1dk1hdHMvczZvU3VT?=
 =?iso-2022-jp?B?N2VjUGY4M1NmdEcxR0tiY0pUOHBYa2J6S0syWGt5OUJtNGd4UWlmREV6?=
 =?iso-2022-jp?B?MWVtdU5XNklFOWRoK2puOE4zc0tzMEdXVmNvaVNma3ZnclF0bWxmQ2Z0?=
 =?iso-2022-jp?B?R3hYOVRjU3ljeU9ZMk1iQnE0NFVNU3NaSkZlTEZTK1haVnRtRnkzVTBK?=
 =?iso-2022-jp?B?MGc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OGFIeVF3eE5Jd3hmWTRSTVZmdmxvU1RGWG85WGg3M2xMT1cyYUNXbUdP?=
 =?iso-2022-jp?B?OEVpaFg3YzhaNTNUbUYzbkM2blIrNlBtNTMydEdxbWRPNWc3VXFrOWhR?=
 =?iso-2022-jp?B?TzUydk8yZFY0TEQ2OE5yZm9aMCtPT1MvRlorZzhYTjVqa2dKVFlFNy9l?=
 =?iso-2022-jp?B?N04yZ2NvM3ZmVVNHdTBGWTBFaXlyTGMxbDloYTlmMEFwQnNaTDlUazhZ?=
 =?iso-2022-jp?B?RDBiVGFRTW1WYVRIdXBzUkd4aFl3RFliUVUwc2FMejkwYS9BY2RQbHhW?=
 =?iso-2022-jp?B?TCtsZm5mNGNBRHp6N3ZQdXNoQitxb0d2cDdRS1ozS2lHclVKbnpMLzNq?=
 =?iso-2022-jp?B?V0kvSEVTT2F6OFcycUJKbUlScUxpL2szOUtSU1FNeEpHcVlhVEwwanZE?=
 =?iso-2022-jp?B?ZFkwU3Z2ckorbHhWQ2dPQ3RiUS9xZW1WOFJvR1YyRGl6M1ZnZEZmbWlR?=
 =?iso-2022-jp?B?eGVlTUMvTWptNkZiNTJhcEUyQnFrdjZ1cWVTeGRzOFRXaWZoemJBbFh6?=
 =?iso-2022-jp?B?eEY1MWFzdDJmSkpQOXBtS0swY0Qxamc2VkVaYnV5VFlRdytsQTRibjZx?=
 =?iso-2022-jp?B?Zk9oZXdsL2VSck9zZGk4Q2hoMkliRXRERDFnem96ZDdHS2hzNVN0VmJm?=
 =?iso-2022-jp?B?QkxrQ1d6N2pVVG1yTHZRb1FsSzVuWU5UOHlxVnVweVdpeVZkcDhodE03?=
 =?iso-2022-jp?B?UXR3N3BKc0oySzhrZENNQVlBYnVaVm1VNUFVS2sweGlzcWg2U2cvbUtn?=
 =?iso-2022-jp?B?d0sybDRYTVJpZTFOOFZMOVV3djNXekc5bU1ITElqVUdRdVZuRzRBMjhK?=
 =?iso-2022-jp?B?a1FWUnBFTzhCT29nYVZjYWkxcFh2VlNneFQxYWFaNUJJOHBDeVN2U25u?=
 =?iso-2022-jp?B?aVVERU9CYWlMUjVrUVBSQWpGRlpsMEJUdlU0TkpLM3BUR2VnVUFsdUxE?=
 =?iso-2022-jp?B?a2ttYXRXQjBTVFhEY21IZXR4ZGlxMFRrNXVrOWtIVERrUE9FeXk2YnNw?=
 =?iso-2022-jp?B?K1lvWkdoQW9qZFJScFgwVHYyV2x5ZUExTkpQTEpSUkY4V2lyOXVuaTZT?=
 =?iso-2022-jp?B?dElqdnloRlR3OHpoR21TZzA0RDQ5c2t0YkRJeGhlUGxlWi9mMzk4RFpG?=
 =?iso-2022-jp?B?dUpKMFNYWE00dnZ2d0dPMTdWeXZmdWd5OFZYREdDNHhDOFY2Uk95Y0Ns?=
 =?iso-2022-jp?B?NW9tSHVVRW5rM2VOdXI4Nzg5UUg5ZWZzb0JacWFnTk53S3E0NmQrZm9t?=
 =?iso-2022-jp?B?TnR5akw5a0VVTjhFUnBLR0F0TUc0NnVjQXdWamY2REdiRGY1Mzg2Rkxq?=
 =?iso-2022-jp?B?Qmw3c2F5K2gxTEtiekR1QzJ6UGdVK3RiclNZT09RSTE1MlEzWVVZUzZC?=
 =?iso-2022-jp?B?ekxURDZiYmVEbW5vVExqbE9HSjlHbjFOcE5EanRqWXdMMkVOZXFleWRo?=
 =?iso-2022-jp?B?MlVkWU5YK1ZCQkVnN0hqSEpWS0JQVTI2Tkp2YVJldzB5eFZzSGNmWXEr?=
 =?iso-2022-jp?B?SHc0VVJTSnJydWI2am91bGdQcVhBcGJ1MHROeVhwSXZSbU1hL1RKSlVw?=
 =?iso-2022-jp?B?eTIrQWNJZEZFRStBYUJxRS84dnlVTWF6N0pKcnI0dWxGcXM2cjdQK1dR?=
 =?iso-2022-jp?B?Yy9nL2FWQUIydjNCYmVnSTJOQkJ1Sk9vY3h2ZC80QTdaeHRUWDBTTEMv?=
 =?iso-2022-jp?B?R2ZvNmw1NDJydDduY3Q5RGY2MzRsN25nay9nTXRmTGtpYW41N2tMNXZT?=
 =?iso-2022-jp?B?bkNVTktONjBad21XbWpWOThTZUlsNHA1Z0xWOE15VTdmSDU4RTN0UlJm?=
 =?iso-2022-jp?B?OGE1Zll3OWhxSjVmTXJlOWU3eE1SSi8wK3FNT09UWjZRNlFJczhick0v?=
 =?iso-2022-jp?B?b29KL0VvdldoTFcxTFJXSFJjOGgrb0I5NWpyZmlKcWxDWDRqUVF5WS9i?=
 =?iso-2022-jp?B?ZzNNYjlNWTR5Q2ZzTDlndEpVSHRYQ2FGZFkrS01pdldEejRhUTZ2MElj?=
 =?iso-2022-jp?B?VGh2UzhwbkdkazNTeGhqVnBpT1Vob1FWTDB2TUZTSWkvVHZZUGRGNnow?=
 =?iso-2022-jp?B?Z3VRVjZmRGVjVDZWQk5yMTlWK25qOUEwNlFlWkNxKzg3b29rYlpRT0FP?=
 =?iso-2022-jp?B?eTNjNkY3bzdmZ2tQWkNTWWFYRGhpdElFNktndlBqOVdWQWdzS2sxTFFF?=
 =?iso-2022-jp?B?WW9TdEQrM0dSTDJWUEVDQkpsOVFhYndLTThneWpJNUVkK2wwYlROVTZW?=
 =?iso-2022-jp?B?cVc0TG9QbElhZlFKY2dRR0JWYnptS3VrU2dPQ2FLSExIeE1mbzdQN3E3?=
 =?iso-2022-jp?B?YkQ2dHFVbXZNemwzSXJZaVBZRkxyZ3hTV2c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103FAAA91FF871B95C6B9F7C2362OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ae7d85-c02e-4a69-b822-08dd13835ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 10:15:10.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdX3y3Q3d7+tH76hIeFp86Z+3kBEtnNRkKw28GA5g3XbFnfGiHCc6/FeZndPR4A8Q4tArIGOuL6IHMRTrMxjO6mXHkyRhw2N8XIXu5UAl/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8058
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Dec 2024 10:15:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17323

--_000_OS3PR01MB6103FAAA91FF871B95C6B9F7C2362OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

Yes we can separate secure boot test case for now and run other tests i.e. =
software update, IEC after booting security WIC image on M-COM.

Regards,
Sai Ashrith

________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Quirin Gylstorff via lists.cip-project.org <quirin.gylstorff=3Dsiemen=
s.com@lists.cip-project.org>
Sent: Monday, December 2, 2024 7:08 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA

Hi Sai Ashrith,

can we separate the testcases which require secure-boot or wic images?
So that we have a test base which we can test now. In the mean time we
can check how to get secure boot and image based testing for the mcom
into the lab.

Best regards,
Quirin

On 12/2/24 14:33, sai.sathujoda via lists.cip-project.org wrote:
> Hi Quirin,
>
> Currently we have only one test case where we verify the secure boot
> enabled message in the boot logs.
>
> Regards,
> Sai Ashrith
>
> ------------------------------------------------------------------------
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on
> behalf of Quirin Gylstorff via lists.cip-project.org
> <quirin.gylstorff=3Dsiemens.com@lists.cip-project.org>
> *Sent:* Monday, December 2, 2024 6:54 PM
> *To:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;
> Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
> *Cc:* hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LA=
VA
>
>
> On 12/2/24 14:09, sai.sathujoda via lists.cip-project.org wrote:
>> Hello Quirin,
>>
>> Thanks for your help. We will go through https://github.com/siemens/mtda=
 <https://github.com/siemens/mtda>
>> <https://github.com/siemens/mtda <https://github.com/siemens/mtda>> to
> understand how this can be used
>> with LAVA to flash and boot the WIC image.
>>
>> As you said, the secure boot image can be booted on a device with
>> "Secure boot disabled" in the BIOS but we have a requirement to automate
>> secure boot testing as well, so we need to figure out if there is a way
>> to configure BIOS through LAVA before booting the image.
>>
>>   If there were multiple devices, then this could have been handled
>> using tags where security image related testing can be directed to a
>> certain device with all secure boot related pre-configurations done in
>> BIOS where as the non-secure images testing can be done on the other dev=
ice.
>>
> How many test case really require secure-boot enabled? Most test case
> should be written in a way that the don't require secure-boot enabled.
>
> Quirin
>
>> We can start a discussion thread in lava-users mailing list to check the
>> possibility to implement this.
>>
>> Thanks and regards,
>> Sai Ashrith
>>
>>
>>
>> ------------------------------------------------------------------------
>> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on
>> behalf of Quirin Gylstorff via lists.cip-project.org
>> <quirin.gylstorff=3Dsiemens.com@lists.cip-project.org>
>> *Sent:* Wednesday, November 27, 2024 7:39 PM
>> *To:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;
>> Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
>> *Cc:* hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$=
B!{#D#I#G""#M#P#S!{#M#P#4=1B(B)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x86 in L=
AVA
>>
>>
>> On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:
>>> Hello Chris,
>>>
>>> We are planning to run software update, secure boot verification and IE=
C
>>> layer tests on M-COM x86 device in CIP LAVA.  To achieve this we believ=
e
>>> there are two main challenges.
>>>
>>> *Booting a disk image (.wic) on M-COM x86 in LAVA*
>>>
>>> We went through the existing job definitions running on CIP reference
>>> hardware on LAVA to re-use if any disk image is being booted on them bu=
t
>>> did not find any. In every job definition, the root file system tarball
>>> and kernel image are deployed separately to tftp. We are going through
>>> LAVA documentation to figure out proper method to boot   entire disk
>>> images on LAVA.
>>>
>>> Can you please provide your suggestions on how to do this, if you have =
any ?
>>> Once we are able to boot a disk image, then next task is to boot a
>>> security image.
>>>
>>
>>
>> I would suggest that you check out https://github.com/siemens/mtda <http=
s://github.com/siemens/mtda>
>> <https://github.com/siemens/mtda <https://github.com/siemens/mtda>>. Thi=
s
>> provides
>>    the necessary tools to flash a device over USB/SD.
>>
>> We would need to adjust the lab setup for this.
>>
>>> *Configuration of BIOS settings on the device's firmware to boot a
>>> security image*
>>> *
>>> *
>>> Basically, CIP security image has secure boot feature enabled, so befor=
e
>>> booting such image there are some settings that need to be done in BIOS
>>> such as:
>>>
>>>  1.
>>>     Enabling secure boot option
>>>  2.
>>>     Adding secure boot keys in EFI storage.
>>>
>>> Only after these steps, a security image can be booted on M-COM x86
>>> hardware. I am mentioning these steps based on our current experience
>>> with local setup. But I am not sure how to achieve this on LAVA.
>>
>> You don't need to enable secure boot for testing - an image with secure
>> boot will also boot on a device which has secure boot disabled as the
>> image does not check the state of secure boot.
>>
>> Best regards
>>
>> Quirin
>>
>>> One idea is to pre-configure the above-mentioned settings in the device
>>> present in *lab-cip-siemens-prag *but in that case I believe health-
>>> checks and all other tests running on M-COM x86 can boot only secure
>>> images.
>>>
>>> Is there a way to change the bios settings through some arguments in th=
e
>>> LAVA job definition ? If not, then can you please provide your opinion
>>> on the above-mentioned approach.
>>>
>>> Thanks and regards,
>>> Sai Ashrith (T S I P)
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>
>>
>>
>>
>>
>
>
>
>
>


--_000_OS3PR01MB6103FAAA91FF871B95C6B9F7C2362OS3PR01MB6103jpnp_
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
Hi Quirin,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Yes we can separate secure boot test case for now and run other&nbsp;tests =
i.e. software update, IEC after booting security WIC image on M-COM.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Quirin Gylstorf=
f via lists.cip-project.org &lt;quirin.gylstorff=3Dsiemens.com@lists.cip-pr=
oject.org&gt;<br>
<b>Sent:</b> Monday, December 2, 2024 7:08 PM<br>
<b>To:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;<br>
<b>Subject:</b> Re: [cip-dev] Booting security image (.wic) on M-COM x86 in=
 LAVA</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hi Sai Ashrith,<br>
<br>
can we separate the testcases which require secure-boot or wic images?<br>
So that we have a test base which we can test now. In the mean time we<br>
can check how to get secure boot and image based testing for the mcom <br>
into the lab.<br>
<br>
Best regards,<br>
Quirin<br>
<br>
On 12/2/24 14:33, sai.sathujoda via lists.cip-project.org wrote:<br>
&gt; Hi Quirin,<br>
&gt; <br>
&gt; Currently we have only one test case where we verify the secure boot <=
br>
&gt; enabled message in the boot logs.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Sai Ashrith<br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.or=
g&gt; on <br>
&gt; behalf of Quirin Gylstorff via lists.cip-project.org <br>
&gt; &lt;quirin.gylstorff=3Dsiemens.com@lists.cip-project.org&gt;<br>
&gt; *Sent:* Monday, December 2, 2024 6:54 PM<br>
&gt; *To:* cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; <br>
&gt; Chris.Paterson2@renesas.com &lt;Chris.Paterson2@renesas.com&gt;<br>
&gt; *Cc:* hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <br>
&gt; &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
&gt; *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x86 in=
 LAVA<br>
&gt; <br>
&gt; <br>
&gt; On 12/2/24 14:09, sai.sathujoda via lists.cip-project.org wrote:<br>
&gt;&gt; Hello Quirin,<br>
&gt;&gt; <br>
&gt;&gt; Thanks for your help. We will go through <a href=3D"https://github=
.com/siemens/mtda" data-auth=3D"NotApplicable">
https://github.com/siemens/mtda</a> &lt;<a href=3D"https://github.com/sieme=
ns/mtda" data-auth=3D"NotApplicable">https://github.com/siemens/mtda</a>&gt=
;<br>
&gt;&gt; &lt;https://github.com/siemens/mtda &lt;<a href=3D"https://github.=
com/siemens/mtda" data-auth=3D"NotApplicable">https://github.com/siemens/mt=
da</a>&gt;&gt;&nbsp;to
<br>
&gt; understand how this can be used<br>
&gt;&gt; with LAVA to flash and boot the WIC image.<br>
&gt;&gt; <br>
&gt;&gt; As you said, the secure boot image can be booted on a device with =
<br>
&gt;&gt; &quot;Secure boot disabled&quot; in the BIOS but we have a require=
ment to automate <br>
&gt;&gt; secure boot testing as well, so we need to figure out if there is =
a way <br>
&gt;&gt; to configure BIOS through LAVA before booting the image.<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;If there were multiple devices, then this could have b=
een handled <br>
&gt;&gt; using tags where security image related testing can be directed to=
 a <br>
&gt;&gt; certain device with all secure boot related pre-configurations don=
e in <br>
&gt;&gt; BIOS where as the non-secure images testing can be done on the oth=
er device.<br>
&gt;&gt; <br>
&gt; How many test case really require secure-boot enabled? Most test case<=
br>
&gt; should be written in a way that the don't require secure-boot enabled.=
<br>
&gt; <br>
&gt; Quirin<br>
&gt; <br>
&gt;&gt; We can start a discussion thread in lava-users mailing list to che=
ck the <br>
&gt;&gt; possibility to implement this.<br>
&gt;&gt; <br>
&gt;&gt; Thanks and regards,<br>
&gt;&gt; Sai Ashrith<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; ------------------------------------------------------------------=
------<br>
&gt;&gt; *From:* cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-projec=
t.org&gt; on <br>
&gt;&gt; behalf of Quirin Gylstorff via lists.cip-project.org <br>
&gt;&gt; &lt;quirin.gylstorff=3Dsiemens.com@lists.cip-project.org&gt;<br>
&gt;&gt; *Sent:* Wednesday, November 27, 2024 7:39 PM<br>
&gt;&gt; *To:* cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.=
org&gt;; <br>
&gt;&gt; Chris.Paterson2@renesas.com &lt;Chris.Paterson2@renesas.com&gt;<br=
>
&gt;&gt; *Cc:* hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(=
B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <br>
&gt;&gt; &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
&gt;&gt; *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x8=
6 in LAVA<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:<=
br>
&gt;&gt;&gt; Hello Chris,<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; We are planning to run software update, secure boot verificati=
on and IEC <br>
&gt;&gt;&gt; layer tests on M-COM x86 device in CIP LAVA.&nbsp; To achieve =
this we believe <br>
&gt;&gt;&gt; there are two main challenges.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; *Booting a disk image (.wic) on M-COM x86 in LAVA*<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; We went through the existing job definitions running on CIP re=
ference <br>
&gt;&gt;&gt; hardware on LAVA to re-use if any disk image is being booted o=
n them but <br>
&gt;&gt;&gt; did not find any. In every job definition, the root file syste=
m tarball <br>
&gt;&gt;&gt; and kernel image are deployed separately to tftp. We are going=
 through <br>
&gt;&gt;&gt; LAVA documentation to figure out proper method to boot&nbsp; &=
nbsp;entire disk <br>
&gt;&gt;&gt; images on LAVA.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Can you please provide your suggestions on how to do this, if =
you have any ?<br>
&gt;&gt;&gt; Once we are able to boot a disk image, then next task is to bo=
ot a <br>
&gt;&gt;&gt; security image.<br>
&gt;&gt;&gt;<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; I would suggest that you check out <a href=3D"https://github.com/s=
iemens/mtda" data-auth=3D"NotApplicable">
https://github.com/siemens/mtda</a> &lt;<a href=3D"https://github.com/sieme=
ns/mtda" data-auth=3D"NotApplicable">https://github.com/siemens/mtda</a>&gt=
;<br>
&gt;&gt; &lt;https://github.com/siemens/mtda &lt;<a href=3D"https://github.=
com/siemens/mtda" data-auth=3D"NotApplicable">https://github.com/siemens/mt=
da</a>&gt;&gt;. This<br>
&gt;&gt; provides<br>
&gt;&gt;&nbsp; &nbsp; the necessary tools to flash a device over USB/SD.<br=
>
&gt;&gt; <br>
&gt;&gt; We would need to adjust the lab setup for this.<br>
&gt;&gt; <br>
&gt;&gt;&gt; *Configuration of BIOS settings on the device's firmware to bo=
ot a <br>
&gt;&gt;&gt; security image*<br>
&gt;&gt;&gt; *<br>
&gt;&gt;&gt; *<br>
&gt;&gt;&gt; Basically, CIP security image has secure boot feature enabled,=
 so before <br>
&gt;&gt;&gt; booting such image there are some settings that need to be don=
e in BIOS <br>
&gt;&gt;&gt; such as:<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;&nbsp; 1.<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Enabling secure boot option<br>
&gt;&gt;&gt;&nbsp; 2.<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Adding secure boot keys in EFI storage=
.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Only after these steps, a security image can be booted on M-CO=
M x86 <br>
&gt;&gt;&gt; hardware. I am mentioning these steps based on our current exp=
erience <br>
&gt;&gt;&gt; with local setup. But I am not sure how to achieve this on LAV=
A.<br>
&gt;&gt; <br>
&gt;&gt; You don't need to enable secure boot for testing - an image with s=
ecure<br>
&gt;&gt; boot will also boot on a device which has secure boot disabled as =
the<br>
&gt;&gt; image does not check the state of secure boot.<br>
&gt;&gt; <br>
&gt;&gt; Best regards<br>
&gt;&gt; <br>
&gt;&gt; Quirin<br>
&gt;&gt; <br>
&gt;&gt;&gt; One idea is to pre-configure the above-mentioned settings in t=
he device <br>
&gt;&gt;&gt; present in *lab-cip-siemens-prag *but in that case I believe h=
ealth- <br>
&gt;&gt;&gt; checks and all other tests running on M-COM x86 can boot only =
secure <br>
&gt;&gt;&gt; images.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Is there a way to change the bios settings through some argume=
nts in the <br>
&gt;&gt;&gt; LAVA job definition ? If not, then can you please provide your=
 opinion <br>
&gt;&gt;&gt; on the above-mentioned approach.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Thanks and regards,<br>
&gt;&gt;&gt; Sai Ashrith (T S I P)<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS3PR01MB6103FAAA91FF871B95C6B9F7C2362OS3PR01MB6103jpnp_--


