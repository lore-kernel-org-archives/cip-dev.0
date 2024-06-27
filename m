Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C914C2BD09
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 13:16:23 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.77])
 by mx.groups.io with SMTP id smtpd.web10.7616.1719494176086331665
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jun 2024 06:16:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=fvsiFzOO;
 spf=pass (domain: renesas.com, ip: 40.107.113.77, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngdcQJQrqNjFLZDHeEle5ShJtGXullbwLf7RvhdxZMcCMWN+e+s/JX0Euz3BZVw3pNHry5rypdz/FcRYvheoecs3KBMhA3PDMb4xpbAhngOcwI/G9623A/BJwhddrlUChV7Tim/DwjquDU6ojs/fk1KnY2ThRgG6wDcCLOeG+eiytzbyfFQcu4BdtGVMTbOy2zfzLJMXkQkv3sJ8NoWreHD6ayirUOTH0cE3ip5t2+7zdAdf/Z0xYmBZU5pN31uqaZG/pJ0lp4EfKSmdYpDnEEHlqeyZIy7MWjaFXVly3mxT3LJXHfyZqGiMU5ca4Zw8mtOmPgyrom8qCCCXYNYSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5RjaW9tQiPwYRuxGMOJv6EhQ/aWL4jYJPhJTrppH4c=;
 b=Rz5JymwNolUXX1LMZHhm5zUp1aa2cljRhjK3LqkLPFwyZNe2ukeigXrIFP0mtvt1rhiVWr+xnk7jeZ2jL/s9pas+L/1vyl7CHVS1Zf2j8A/prdxtd/JYGe2VaP1T2DyHpqqqSPf5cN8cIuYQjG7f4+zLECTNJ/7UTAlEHZHbryZpEyLHSEE3meyRdq37CUfubXJkUZVFzoya1ghb0HXHF/o/nA2hCvXeijvKlaYXeYKKKIesnPc/CODyj35mijh5//yV4oQaGrPds76b16Crh+TN2OGeSTUnX+fG5EmQc3NfUv5NjrR1PCP9vIY4ZQ70uhXV19JG4A9MVIQ2D+YC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5RjaW9tQiPwYRuxGMOJv6EhQ/aWL4jYJPhJTrppH4c=;
 b=fvsiFzOOQz/fzeUJyQSsaK/wA1rQkK52b9hAAVATSFwmrdDIZzsYr4V3DNA3fg+NV2VlN7LOMY0Kt6gxrZwD+gwk5jLIFpkD35q9C7NU44Q1AQC4rxmmQl6Se0YTPwAUy/KtW2GnDjolu8pK2Nww31wTSB6uJTwXsjYWZlPP0XQ=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYAPR01MB5756.jpnprd01.prod.outlook.com (2603:1096:404:8055::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 13:16:11 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9%3]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 13:16:11 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Generation of test reports from CIP SQUAD for CIP Kernel and CIP
 Core
Thread-Topic: Generation of test reports from CIP SQUAD for CIP Kernel and CIP
 Core
Thread-Index: AdrH5VmRUEDgCPekRs62LtuK4XbxNAArY+5g
Date: Thu, 27 Jun 2024 13:16:11 +0000
Message-ID: 
 <TYWPR01MB118621D82BA75AD7291B1CAF5B7D72@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103D9F8FA680A7378453867C2D62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103D9F8FA680A7378453867C2D62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYAPR01MB5756:EE_
x-ms-office365-filtering-correlation-id: 640b4132-40f5-4c65-5699-08dc96ab50cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MGk5eDYzc09RODQwWm0zdENjTnlBd3R6QzdldmhPakRnS1YzOVdxZGgv?=
 =?iso-2022-jp?B?eEZpQnpSUExGZlB2RmtHazI3VlJRV0Z2ejMvNHhHbmJqckxoMS9nN0Mz?=
 =?iso-2022-jp?B?U3pmQWNRdEhJTUE4aUZKbisvMFEwSlR5OFEyTmlVcWtGdXZwa01ra056?=
 =?iso-2022-jp?B?LzBCTHJqeDRhRTZXZ1ZRaDdZWitXYUhjVVFzNXJFUm5VQWZTZlJKd0RG?=
 =?iso-2022-jp?B?bzEyYXVQd0Fnd3ZxTzNUTGJHZnIzRVZCS3N1eSs1UnVvREoyQXI2L1Bm?=
 =?iso-2022-jp?B?RmlGUjBIRkVkSG1Ga0l1S1ZWdXlhQzNPWjUzWnlMdnFEZUY4ZzJ4dUxP?=
 =?iso-2022-jp?B?c0VrMThaVU81WDdOV3ExY2dOai9oL3NTM0FkTHcrT2lmeCs1WUp5VC91?=
 =?iso-2022-jp?B?dnJtYldMZDgzeFc3UTlpY01WUUN5MmlmbVhlL1NZQ05tL1ozODNwSS85?=
 =?iso-2022-jp?B?dWNXQTZENXRKbTFVMVc3YUxUVWpTTW5jOExXNGZNcDhLUVdNeWdjQy9F?=
 =?iso-2022-jp?B?SmZUc2VDQ3JEalBOZWJUZmp0dWhkWHdVRjVUY3dMRWhiMEhYUVRka1V0?=
 =?iso-2022-jp?B?bTdIaUJmQXZZSWlzOThTUDJmT0NXZjBRd2YwN1pzZlhXSk90S0dtUndz?=
 =?iso-2022-jp?B?UmhCVmtYTFJnQm16ci9pRUF6RGFMbThTTmVwOHl0dUZRMUlUcklRQlYz?=
 =?iso-2022-jp?B?RTBNM3d5ZHZUNTRCaC9wem9wSk9LdDJGelRMaGNCVElCcVBNQW4zMVVJ?=
 =?iso-2022-jp?B?Q3pOQW4xTXJuZXAvN0NqSTJieTN1U2pxcjFRWlEwSlRZbG5uSW1vTFJq?=
 =?iso-2022-jp?B?UWlGR0w4bmFzU2FlRFRCd3hZbTAyYTIreG9mL3RVMTJ2bHQwc2JFQmFZ?=
 =?iso-2022-jp?B?UkVWNnpMbkJUSjQ3SzIvUThPclAyRUtUdDhaNENhOUJCWTlCSU4wOTZ0?=
 =?iso-2022-jp?B?SVdKSkc3NVpkQ2R1bnF3aHQ4OFdad2s5akZoQTRPTGZsSGtZdWkvUmh3?=
 =?iso-2022-jp?B?bUZRcGJ0Q0pQSytoWDMvajNrWHJiRXgzb2Z0OG9zQ0VCRTZrdHZ2RWdu?=
 =?iso-2022-jp?B?ZWp6Ym90RFRWOXFucGFHR2d3TCs3aS9ZNHpJWVhXcWZiRUdEUUdtVTFn?=
 =?iso-2022-jp?B?eW5XUHNSNVlZSkt3L2JOeURYRDh2aW9GdkZyNEM4STJzd3M5eXNzRVo4?=
 =?iso-2022-jp?B?QmYrWUhucFFyRURqOUhsTXZNclZyQUpmRk9Jam5ZTklRRXNsNEdGSTBN?=
 =?iso-2022-jp?B?NzlHV3Q3TWRmVjB3clFDMmxUMCtkazVpdlV5WGhNblg1Sy9tTUY5UVZp?=
 =?iso-2022-jp?B?NVpVT01lWW9vMlFGSk80OVl6L2xFV2JLRnhYY2RnTTFVV3lWTUt3ZHRj?=
 =?iso-2022-jp?B?L25aQVBYMlg3bGZhM3dwNENHVVRZdVNPTmR1bEhSOGRPTVJwZTRWenU0?=
 =?iso-2022-jp?B?Vm1kUDFJSlJuRzJmSHhJOWNhV1NrMFhyQ2o2ZWpYVVYwZEtqKzFsYUxs?=
 =?iso-2022-jp?B?TU1rMDVTeW80a2ZYUUhCMDNHSGpUeThVTHFEN0JCamVBRFF1QWRRRTBK?=
 =?iso-2022-jp?B?VUVSUnhxRTd3cEJ2bVphdmJMTUVwSkZCTG1uZ1VKRWdvOS9RWTY0eEJp?=
 =?iso-2022-jp?B?NGp3UVY5U3VHeGN5SXE1T3AzeFFlbE9KaUFzV1JpS1pjRXdtaU83cHhl?=
 =?iso-2022-jp?B?VHA5dklBZjRZbGNlamJYck8yMGgxY2ErWVBYRXdQMnh2NnlSRFRjMGdV?=
 =?iso-2022-jp?B?SVRsOHNoWGJqME8vc1FZMmF4ZkFDM0lURVBnT29vS2poRGdjMlBhZCtK?=
 =?iso-2022-jp?B?elB6aUY0emk4UzJIZFlvUDNMdDFKTlhCOUcxTWNSdUpYaVc3ZVI2UVBS?=
 =?iso-2022-jp?B?RUkrRDdIRVhLWFdWRUJERDN2bTNiRWVBbm8ydCsvTmExWDFnYzZ0WHNi?=
 =?iso-2022-jp?B?UDVibHRYeldWeWtnYTF4dFBUakF5Z0ZMY0lnWnA4dk5wVk8zTzdONlFB?=
 =?iso-2022-jp?B?az0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dGxrekUrVERib2h4UklqTHJVZWZRT2R0VnNUQ29XalJ5YThsSVdXZTht?=
 =?iso-2022-jp?B?NFgxRG1UR3NEdGRBSWRSUDVZSEQwUzZZVnlRMG9UZEVJaDhnRFg3K1No?=
 =?iso-2022-jp?B?K1M3UitWQ2Z4dEwyQVFPczFCbXlrUHZ0VzdUL3VCTUIrWE93S2J4YmlI?=
 =?iso-2022-jp?B?L3hFZUdEQjFrRlZHMU5uRGFBSHdtVlhoWTdvNXVkV3ZHWkphZFlseEJV?=
 =?iso-2022-jp?B?YzdDemVQNHFybHV6bysxc0MwRVBCd2RUNk02ZTgwbm1QVWpkTXpsYXJn?=
 =?iso-2022-jp?B?aGZFZVRPQmVTY1RZRG9zNlVBNFVXYWtQY2tiSDhJNi9sRzd5Y2VMTWdv?=
 =?iso-2022-jp?B?TTlhMkhiQkdha1lmbDFDcDBmWDZ0eTFLT2JydHM5SGJZbUdJaG1tcWxv?=
 =?iso-2022-jp?B?L25tcGdWcVNqUTJYSit5TkhuMDZNbkNIeFVEM1J0ZEFoUUsva08rVTJv?=
 =?iso-2022-jp?B?d1g3R2hMV2hzTXh2YVRvaEFLQVZKV1NubDhDdFVrMVlDYlc2RGIzWkFZ?=
 =?iso-2022-jp?B?cXphZnE3ZmM4OWtwWGlHSVhNaGU1enN5Tjd6QytLTHZkQUN1RDBwc0tu?=
 =?iso-2022-jp?B?TFFXeVlTcndhd2dPaEh0bURoMnVXb0t0RWg4Skt5YzE1UHRzSmw2bk9N?=
 =?iso-2022-jp?B?SU5PNkF6dXBseVZyZnpTRVM2NDMwa2MxVDhxb1NmVHlwbHVkcEh4ZmtG?=
 =?iso-2022-jp?B?ZEFqbHBxc0g3TmFocmVJNXFlVFp0SG1xdmpNajdJL1RuL3dLS3VyWTZC?=
 =?iso-2022-jp?B?bllJcm5CeUxkcm1Zbm5PS0RQMUJja1pkck4xVml2dWduZjhzNDNRektD?=
 =?iso-2022-jp?B?NERTNHFUVks5N0laSXFwN0xEZUdERkZuTXRUWXhKZG96RllidG1meUVs?=
 =?iso-2022-jp?B?SzNoTEpla0NHY2x5WlpwMWtXUU1wQ2lXVEhiSk5qUXQxSVV4b2JreEJR?=
 =?iso-2022-jp?B?aGlJOFpNdjl5M21kYWwyaEROSmZGQis0MHhUMldHa3B1eFFyMnRFYnJj?=
 =?iso-2022-jp?B?RklCTFg4NFBaODNuSVoxT0pjb1l2eVpJSVlSSmtGMWllaTA2ZHdJdWp5?=
 =?iso-2022-jp?B?aDNROU16SWVpQ2U3MzBXdXZZK0owVTdjdDlhOVFtcVpkclR6UmpjOXRE?=
 =?iso-2022-jp?B?NDF6ZG1QV0tiM09NRkxxc0FFQ0pFRncwQjUzVm5ORDU2OWVyNHRiZ1JS?=
 =?iso-2022-jp?B?ZXJ1LzBmMlBGL0ViZG5FRUhmWmZyd282M2NEcWNlSlAvYS9LQUdpbXcw?=
 =?iso-2022-jp?B?WWhncnZvV0tDTjRwUk5Cb0VQWFpTRFB5NTJ4Q0dwTzNiZVJEY2RoeDRj?=
 =?iso-2022-jp?B?bDBlRzBQS1ltR3J1cXhpRnFZUlZSSlJ3OGlRdkR3czJRZVZ2VEJUZlph?=
 =?iso-2022-jp?B?c1BybUV1RWNnMG11cUlHV3IxNUNzbS9XRFFlaXoxS0Vnc2ZJYlBPdEph?=
 =?iso-2022-jp?B?cEVzNHFRbUIxWUJ4b3FNLzVFWjllR0VqY3RXaXI5ZlVHTmRWaG1acjdO?=
 =?iso-2022-jp?B?RS8wdXFLN05aS1ZIajZBSHNJVUVIQkJtb3g1T3BiS040UndjNUFlUjNr?=
 =?iso-2022-jp?B?ZjRzNVlpRWZrK2xobkRuYUtDVTlObGEvb2FIS1RhaW9MMUljdXVrWkZK?=
 =?iso-2022-jp?B?T0ZqVWFFVi9mTEoxdnVsOHBYNlV4U2NkL0h0MTI4Sm90TXNYMldHeUND?=
 =?iso-2022-jp?B?eDFVR1htbERzRGRreExaS0paYStRR0NaVGhVbzZ4RVAxVFZhK2hQcEJ0?=
 =?iso-2022-jp?B?c0o5SmpiTld0Q1ZONFFYL1ZIMzZ5aDlVOGNhcCtoRUZ2ZHBhNmd4Mk1S?=
 =?iso-2022-jp?B?SUhSSW9YcGg5UGd1bVdVTkZSRHRIMENvd1hyYWtVSHZrQmdkT0FFNTFY?=
 =?iso-2022-jp?B?UUJPNVl6U29VdG1NSGcyRXVSbExWUC9zbjkzM1M5dEcyM1Y2V0RFQnhG?=
 =?iso-2022-jp?B?RjFCMWRYTHNxNXBwZ09SYy80WkxMSjJHN0hJMTUvSHFZNnJjRkMyWXdp?=
 =?iso-2022-jp?B?VXc1a09QU2tGbk9EUzlXM2sxeGh5U2h3Qmg0MlNnb1lxVXpWQjFHNzE4?=
 =?iso-2022-jp?B?dFB2NGIzb2tzaDZsZUhLa3Rud1lSdmdvS3Ewck1RRGFkM3lJSytQZlR2?=
 =?iso-2022-jp?B?T08zS25RQUdtRXVxalEySVRFQkJuVURwYjRRS3RBa2RXVFdKMUVWZkJC?=
 =?iso-2022-jp?B?WFoyNUFqbnk1d0NoeHZ5TU1wV0VoUzRHdWwxV0lkZU9jbUhJNDNGZDZG?=
 =?iso-2022-jp?B?NEVaZk96ZndoaFU0dUhuOU9CZHVvTER1S0lIMEZRWER3QkVmQVkzbzI4?=
 =?iso-2022-jp?B?YXQydWdmQnpKcWlRaSt4YjhIT0UxbHR0Q1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640b4132-40f5-4c65-5699-08dc96ab50cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 13:16:11.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yq6gVad+cBMWg8W7PEhrxqwYw8eQaMs/IaHPI1MvnhZ5HdTxKztoTyeKQL/Ok4fnzZqzPAsP0Cz+FhAjjvdRqzqlFSUjnSxPwjZDTzdxi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5756
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jun 2024 13:16:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16337


> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Wednesday, June 26, 2024 5:39 PM
>=20
> Hi Chris,

Hello!

>=20
>=20
>=20
> Hope you are doing well.
>=20
>=20
>=20
> Currently I am working on generating PDF reports from the already
> generated .html reports in this project https://gitlab.com/cip-
> playground/squad-hacking/cip-release-reports. Based on suggestions
> provided by Sietze, I am trying to open all the data hidden in details ta=
g
> in the html report after they are generated and then generate the PDF
> reports using python-pdfkit. But there are many links in the html report
> which re-direct to the results present in SQUAD platform. I believe these
> results present in SQUAD have an expiry date, right ?=20

Not that I'm aware of. I believe they will stay "forever".

> Is it possible to
> configure SQUAD backend to store selected results without getting erased
> after certain time.
>=20
>=20
>=20
> It is not favorable if the links present in the finally generated PDF
> reports sent for assessment stop working after a certain period as the
> date is erased from SQUAD. Can we do anything to handle this issue ?
>=20
>=20
>=20
> Since Sietze moved out of CIP project, with whom shall I discuss from
> testing work group if I need some help while generating PDF reports in
> https://gitlab.com/cip-playground/squad-hacking/cip-release-reports ?

I guess me, as I'm the only one in the "working group" :)

Thanks, Chris

>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
>=20


