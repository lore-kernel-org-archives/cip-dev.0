Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FBC83F1B
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 02:38:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.5549.1752547086755755220
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 19:38:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=F4hTIwq/;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752547077;x=1753756677;bh=322noHhOW+0FcVwdkDv/ETpSKARxJbi5CggF5F/
	LeIg=;b=F4hTIwq/tWyDuCj7bPtyik44uKkAU66KUNX+fLdnDUGjDdoDZIdFA4TA8t7/IP1prZYgY
	9etXzxUso1kZGP4R7KaupPAJGsR2a8zyLUnTMx/szbw7/dJ5glOSkrs+ayW0/G5hfgruwk4hf3ute
	8gI6WCOIRKl3l2id1aEtwxe4Mr8+pcCIScEgI0ChrpRFN5r7WTHqrEhlkWLfFWRWVtpiHXG7mInHw
	vf9F42ViVtw0jD+qwKRquB94DAjmu15WvYu6oyWnmVZU6h4Aj59JQnB+JoJeRqZvCSXL9q6/+trEL
	vcGctWTVGvaIApcsAiXxmneNZ8A7U4GsyHSLCxjg5w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 56F2bu2C1661026; Tue, 15 Jul 2025 11:37:56 +0900
X-Iguazu-Qid: 2yAbG2MEIy9cInWFfA
X-Iguazu-QSIG: v=2; s=0; t=1752547076; q=2yAbG2MEIy9cInWFfA; m=Cb78eP1srog+Q9qfZMuoqSpetR+LdmYJEQxqGfQcooo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 56F2bss72341752
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 11:37:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZI+U+D41HgSpKLbaDUaNm4UMacnlrRjQFrUJc8w805WUsIYUPtlRIZMJCUIl6RuGIzXAdYbSmEbZL6RD38IDO1KwZBRxeOuZZ5XcyCv1DJErWeZ7+5mkg/i1AK74MKiSHLeh0WRU1mfwRdj93A7bIu+PULQKKDgn2whUlvbnxy8uNlhhohbQE2Z7CKyzkyf8ooOiUViGB5SkKK0Uur14Pvaj0I18EcG7W7MXLYEj7ByQTDr/9Y0+MgLKk6oSmXG1pi47bfW4DYd8hSyABIgTH9E9nCQ38lJKC2Q4tPi7WLlYw4+82H0N8ekiLnaMXvmSLz8STnocaXS2F/oOlBKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmiM/ikTpnoKpZtoRQ+wKAjKpuBQenjMnhy1T3p3pX0=;
 b=XYl94ZR/ThDFI9Q6i92WrDzUgSzkf5G7+vRlfjDCF63JvHzG6qB3XiBurgzeXsWJi2se2dX3eq/qBxSOaS6vOo7Xgdlv/I/nsADbnwiLkTaclpa0Vzevq7ytMJ0WQ3Jakp6JA2HDcsZ+oaJcqYZDDF7ulnqbacCW1RutENzIzRn3AZGpGyRnPxX3C8TOUh/BSllr4JbJzxOBh/BKYNqekSzHugynHyXKBveMGz4NoNjUYIsT68cvun67H17a6zexrC5q6P9e2wOrl7ou43/svY1D17l4jmBXYa7RwEt+M6puzQFORNbTC8pDu9p2Y4OfxXeAfDTIVCgbS2QoxkM5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 00/57] Add RZ/G3E CANFD support
Thread-Topic: [PATCH 6.1.y-cip 00/57] Add RZ/G3E CANFD support
Thread-Index: AQHb9Kc38P3GX4sylEajx7Q7l+VVdLQyeV5g
Date: Tue, 15 Jul 2025 02:37:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481840869EEEC9F33313D7379257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS0PR01MB5570:EE_
x-ms-office365-filtering-correlation-id: 34341c1b-326c-4dca-a378-08ddc3489940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TCtxQjIyM3cxQTdUcXVFd3MrNVV1YUl5ZjR0Ynp4MnVGWFJVVkFPT0dt?=
 =?iso-2022-jp?B?cGc5L2l0d2lWb05kTEI3U3hhamlRbjR2cUMvT1JpV3h4ajB4eEJ4aUpp?=
 =?iso-2022-jp?B?di80bkQ3enptTUdVczdmUTYzK05hTFJobkU0MmlNQ3M5L2c0c1ZrQXdY?=
 =?iso-2022-jp?B?SUVFTzN5aDBURW4vb2hTRlhNRUJqWGIxMGtqemFEV0V6bTEvTjZzTzQ3?=
 =?iso-2022-jp?B?WUdQcnQ4K21qV1RGall5dldGQWR4WlIwWmJHMzY4VDU5QjgxN2lmSkpL?=
 =?iso-2022-jp?B?dWVSd0VyVm5FRnJVTW5ISnU3VlQxTVYydnJuUU5wR3BIOHpMa0RsVTA2?=
 =?iso-2022-jp?B?MTUraUYxaS9aSWFDcFI0Q3RSMkRHaXl1c29kb1ZsTDZicVdVbDlsYUJQ?=
 =?iso-2022-jp?B?V3lPZ1VCVCtCczkyVklTSjJvd1pEdE83Sjh2WFFnVVptRDQwbXRSaHlS?=
 =?iso-2022-jp?B?TjZVWkpXWmw2dWtDMHpmK2VYKzdpeGE3Q2lrdWpEcS9VWm1tWXJ1cnl5?=
 =?iso-2022-jp?B?ZWdnTzZ2bkhVazVlQ1JzSnJvUlZObzRvOXo5eFVjUXpJN1JjbWJ0U20z?=
 =?iso-2022-jp?B?THJkaHpISXFadnNPL0FRUFN3TEt1THNiMXFKQ2tXNVdvWFoxc0xsalRR?=
 =?iso-2022-jp?B?WTZmWUFkQjh0Mkdha2VPODYvQnZuR3RXUUtvS1lpYXBwTU9iU1M1Q0hp?=
 =?iso-2022-jp?B?UVhYSlZjRUdNSmtDUzFmM3U0aHdrQlBQNGd4bTIrbVZ4YjJPcU1pMWZm?=
 =?iso-2022-jp?B?RmZoRzgxKzhwWmY3bk5jNEM4ZnNrZ2hxZjlCQncycmRRU1pFN214cWxP?=
 =?iso-2022-jp?B?VkVYQTdkZTNYeW9XRGxpakM4WTZ0cWw5WG5ONUVnQXZ1c3lHa1pZb0wz?=
 =?iso-2022-jp?B?L2U3bmNSUGFUbTN4VElLbjRqSTc5UUNjM1ZHeHVDSGllWUc3M0VmcGpC?=
 =?iso-2022-jp?B?RnB2cUp2VnlxTVJXWmgyODk1WHBMTDhwUVVER1NNUGM1azJJUG1XdFdX?=
 =?iso-2022-jp?B?NGJveVNhK21jSGQ4aU5QZnBoSy9VdHh4Y01RckpRMUdWS2J4amFsSnln?=
 =?iso-2022-jp?B?c3pnREhhZDRXUkhIUGdseGp0TFZBMWxFR0lISzRNN2xSalNOd2pSRUlE?=
 =?iso-2022-jp?B?bE10Tk51YjBWRkRzdmh6QzZFcHQvMXhqMFdOVGRlQ05TN2F2czYxbzBy?=
 =?iso-2022-jp?B?MUw5QWNtb3o3Q3hMQlFWQzQ3dzYxZVF5ZnZXdkMvNTZISUZKTUZZYktW?=
 =?iso-2022-jp?B?ZFdML1h2eGFhMlhKcGZ1cDA4RUJpM2k1U3JPZU5oU1J0eFhDaEg0Nmxm?=
 =?iso-2022-jp?B?Y3drZGJCTjUvNGkvTWhjemdWeGxaS3d6ZExCQ0ltM3E3QUgxSDlFWndo?=
 =?iso-2022-jp?B?b0Y3bGt1Z29LbmZDdXdjYk9UdndteFVNNTdEOTFadHVKT05TcGFZeko0?=
 =?iso-2022-jp?B?VmdKZlR6YTJnSWoyd3BDTHRzenZSbURibzQ1RzNIOUptZ3RkbXh4cjd5?=
 =?iso-2022-jp?B?clIrbkQ1Y1crdzJFWXoxYWc3SDNqb1RkdzhEU0w5eDZSZjhyV3U3UkFp?=
 =?iso-2022-jp?B?Y2tyWmJaY2ljZWxmQ3NrbXRaUlFhejJpL3JURlh0MXNEeWhhYW5YUkt5?=
 =?iso-2022-jp?B?OXJtZGxBMnhHd0tVdzVWRlNTOWhoNXRMUlQ4MURxZm5zQ3c0SzRhTHBI?=
 =?iso-2022-jp?B?a0dPdnNJSDBVT1FSVGVyZUM3azdNQVFQVmVnWkZhTjk5bmpYc2xDRHJt?=
 =?iso-2022-jp?B?RjRWZjQwdG45ZXFpWXNLdXRDbDVJbW9DY092bGhPTHhFRUduNGxpSGJW?=
 =?iso-2022-jp?B?allUVkc2OUtJY0Y5cFB6TFNSWVJKYlM0VmNNVXVaSEIydUZNZisyTWpT?=
 =?iso-2022-jp?B?SGVmR3dOdzNIOHRJbnljcG5zV1hOTjN2YTQ3elVPbjZzamRqaEJDV1Rh?=
 =?iso-2022-jp?B?OVF5aGJrcHg4dEFMUXJuSFBhbDZwMmJ3R1IydWFaaUUxdFN2R0J4RHdu?=
 =?iso-2022-jp?B?V3kvTSs1N0ZoTTUvZytVYXNVQWg4bzkvUk54TkpxN0VsandmNzBYdmZ3?=
 =?iso-2022-jp?B?S096U09VN0lWeG02SWhNUFdNSW8xTXlaWENqTWVLNXZNVjl4L01Xd0Jp?=
 =?iso-2022-jp?B?cjZBWEovYTBJT1dOKy82RnA0bURVMERYbkNmT3c4bS9oblREQk0wY1Nh?=
 =?iso-2022-jp?B?YUljPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MUlaQitwczBUVmVqNmN6Z3ViclJVMVdudm9MeExvUSt0UERGUFcvOVB6?=
 =?iso-2022-jp?B?K1dTREhlaUtnL3BhRWw4d3p6Z21EeG00UE9VTVNSOUVCd0NRWXNrMXBs?=
 =?iso-2022-jp?B?NnV5cXlvRTF4VkhwVWJ5NHZkZWZWcElUVlZKMTZhQ0FCaENKZWZTaTJy?=
 =?iso-2022-jp?B?NmRVYUVzYUxpa0g2dHRPc0owU05ESnZxN1hLZHg0cEliRXlINmlkZ1h0?=
 =?iso-2022-jp?B?WW9TWmh6MHlwN2R5MU56K251SnpJcWMvbElzMW5RUC84V293M1hoT0kv?=
 =?iso-2022-jp?B?MEsxNEtTS25CdmlpRW1UdTNaeDBSLzJvUS94YTlXbnByTnlQZ0pQK2NM?=
 =?iso-2022-jp?B?YUorWmZIaDMrOC9ramVxQklIN0Y1OHdqZVYwb3NaUTlYYWtiUkdOeFl1?=
 =?iso-2022-jp?B?ZUNHOVNOUGtsWFhJWTJGclZVZkVxd0NEMm5xL1Bra3g2TmJtcDcyb3Bm?=
 =?iso-2022-jp?B?ZTdISE5kS2krZjVFZUV2UjRSUUNxbVQ2ZW5uem1pZWFobDdjdDUzT3Fa?=
 =?iso-2022-jp?B?NEIxNVZBOUFrMFRlZWx4K1RvUXQ5MVZlQVJiVnVmZEZYSnRrYkx0bWI1?=
 =?iso-2022-jp?B?K1J0VTJ0SG5lNWlzTkluS3J2eDl5RFRTVmx4YjFyWGxINjVXQkM0eEQ1?=
 =?iso-2022-jp?B?bDhGRDVNZ1lUVHAzMzJHSUhGcmR5MFRiMmhmOW1FOU5LUGVoVm9EMnNO?=
 =?iso-2022-jp?B?TEVxUUp0c1ZLakhxYXphcGVrbHp0WEpqSVJQTWk2YjJDRG02REwrRHBx?=
 =?iso-2022-jp?B?R2RCNDd0NHZmWFZvSGRNeUNTbnNmU0QwdlZONEdiWlZMdWpJS205VXpr?=
 =?iso-2022-jp?B?VHZDZmdRWjBOeE9heEJHVkl1Tzhrc1dtYmF0cFlidDEvVFJPS1ZhbXNI?=
 =?iso-2022-jp?B?OTcvZjlCTFB4aEUyamFFbHloSzNjUGhJck5HWWJqNjcrWFFKYUVwaVdj?=
 =?iso-2022-jp?B?bzhOd0liUzNvQW1iV1RiRkZVbHdZYVpQTUtjOHJQZXpCekx0cGs4M0xY?=
 =?iso-2022-jp?B?UGp1SkFjNzFDS0QwT2pWY08xMWE5cFJ2TnZOd3lBVzF1WGkwTU1odFd4?=
 =?iso-2022-jp?B?dHpHaUZ5K1RuK3NPTkZaNXlkVllCbEpwYTRBZDlrOEVrcG43Z1hmMzBs?=
 =?iso-2022-jp?B?dkEwUjFoeC9EdEFMVEhtN1AyRG1QeENuM2dOV3dIQzJLNzFXazlYYU4w?=
 =?iso-2022-jp?B?c0dTVXJJcUFhdi95cm1tZkMyNHRHLzdhNlpSUUEyMW9SNTZ3M2FOUEg5?=
 =?iso-2022-jp?B?ZFZMZUdEdEdWUm1JN1diVzJVZ1VDNnhPZHZOamdjd0JRUWNKN0pmQWVp?=
 =?iso-2022-jp?B?Z0pvVmtGdTVhSitzRS82cEVrcmJyNklGQWNPK2VHNDAzTm9aUE1hOXZC?=
 =?iso-2022-jp?B?czVuTko2Q0szUExxVWpNbjBmSG93ZVBlbnFYdjI3cW9iTmRQNjlCcFh6?=
 =?iso-2022-jp?B?Y3k1YWRhUGtQcjZHWjlsaExqYmtWalhBSWUyd2s5S3pQU0s0eFVGY2hR?=
 =?iso-2022-jp?B?UkJmUEhuQ2dNSTQvcStmYmtjVGJsdHNhemcwU0pRajZDbjdNRUdHQXJT?=
 =?iso-2022-jp?B?TGF6bVBKenU5Qi9GT29naGorcG42NW12ZkZlQkM1Y2piQkRYQXExTlpx?=
 =?iso-2022-jp?B?eWM2dlN5Uk1POHV2UFFvZkYrbmdwb3IxWkF0OU1QY2JSd3NYdW1jLzBD?=
 =?iso-2022-jp?B?bVNKZmhLaWwwTW1wanhLU0ZsTzFVUjdZK1FNLzJaQzFCbzZKdVo3bCtH?=
 =?iso-2022-jp?B?enUwMWQ1OXJtVnpvQy81d3U1L0wxT1JnNklzWTZIZjFCZWdCelRNL2k4?=
 =?iso-2022-jp?B?eUJOMitvVnJLWXdzQ3YrM0hiRThVSnNGQ0hYMXZackFNdHhwR21oQVV1?=
 =?iso-2022-jp?B?SDNtZ29heWlTM3d6L2RBM0Q5QWVVR0IyM0NmVGJYNTBBTjVGYnpqUWpD?=
 =?iso-2022-jp?B?YlFjQXJRZFp4RzNNcUcxOGxsalZ1MHZTYlJoK2pyenlQOGdTMmtPOFBn?=
 =?iso-2022-jp?B?UVJ0bUdzaUNJSExES2ZVQzFYbU9Tc1prNDNrNVdZZEdLN3dya2N6dGJt?=
 =?iso-2022-jp?B?NjdvdG5xdVhGZ3FneFZtcHd2b1h6TGl1UllVbG9jVFhubGh2dGRiVURo?=
 =?iso-2022-jp?B?Q2NSSzdLNXdLMER0bTBhWkp0RjNaZFQ2MCtQekhkcEpMZkxWMmJPdWVs?=
 =?iso-2022-jp?B?L3JhQnQyTCtqL05lbTdiYU0vT0hqcFFkby80bWN1NCtWeUVxeTFsQkRj?=
 =?iso-2022-jp?B?R1p0UE5weGpYMnZBcys1WnAyTlNLdEVjeFB4aTZYYVR6ek8xa3V0ZnVp?=
 =?iso-2022-jp?B?QVFxaUU2c2pqREdySm84MVRHWHAxY2tZb0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34341c1b-326c-4dca-a378-08ddc3489940
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 02:37:53.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T96SgwRhxBFthrGGHvLh3VUN0dqtSpD6hJwpMNZNHzKzL9exielUH8fAciz6SC4x7ph7CXzrBKwvqNVt263QmED/V57T/MHSX1FRn0r0YXXiPl7bhOSSffVRnfI9b+NG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5570
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 02:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19531

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, July 14, 2025 7:07 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip 00/57] Add RZ/G3E CANFD support
>=20
> This series adds support for the RZ/G3E CANFD driver into 6.1.y-cip.
> All the patches in the series are cherry-picked from mainline.
>=20
> Andy Shevchenko (1):
>   lib/string_helpers: Split out string_choices.h
>=20
> Bhavya Kapoor (1):
>   arm64: defconfig: Enable CAN PHY transceiver driver
>=20
> Biju Das (25):
>   clk: renesas: rzv2h: Adjust for CPG_BUS_m_MSTOP starting from m =3D 1
>   clk: renesas: rzv2h: Fix a typo
>   clk: renesas: rzv2h: Support static dividers without RMW
>   dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
>   dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
>   can: rcar_canfd: Use of_get_available_child_by_name()
>   can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
>   can: rcar_canfd: Update RCANFD_GERFL_ERR macro
>   can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC
>     macro
>   can: rcar_canfd: Add rcar_canfd_setrnc()
>   can: rcar_canfd: Update RCANFD_GAFLCFG macro
>   can: rcar_canfd: Add rnc_field_width variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add {nom,data}_bittiming variables to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add ch_interface_mode variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add shared_can_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add struct rcanfd_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add external_clk variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Enhance multi_channel_irqs handling
>   can: rcar_canfd: Add RZ/G3E support
>   arm64: dts: renesas: r9a09g047: Add CANFD node
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable CANFD
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable CAN Transceiver
>=20
> Geert Uytterhoeven (18):
>   dt-bindings: can: renesas,rcar-canfd: Fix number of channels for R-Car
>     V3U
>   dt-bindings: can: renesas,rcar-canfd: R-Car V3U is R-Car Gen4
>   dt-bindings: can: renesas,rcar-canfd: Add transceiver support
>   can: rcar_canfd: Fix R-Car V3U CAN mode selection
>   can: rcar_canfd: Abstract out DCFG address differences
>   can: rcar_canfd: Add support for R-Car Gen4
>   can: rcar_canfd: Fix R-Car Gen4 DCFG.DSJW field width
>   can: rcar_canfd: Fix R-Car Gen4 CFCC.CFTML field width
>   can: rcar_canfd: Sort included header files
>   can: rcar_canfd: Add helper variable dev
>   phy: Remove unused phy_optional_get()
>   phy: Add devm_of_phy_optional_get() helper
>   can: rcar_canfd: Add transceiver support
>   can: rcar_canfd: Improve error messages
>   can: rcar_canfd: rcar_canfd_probe(): fix plain integer in
>     transceivers[] init
>   can: rcar_canfd: Simplify clock handling
>   can: rcar_canfd: Improve printing of global operational state
>   can: rcar_canfd: Remove superfluous parentheses in address
>     calculations
>=20
> Lad Prabhakar (10):
>   clk: renesas: rzv2h: Update error message
>   clk: renesas: rzv2h: Remove unused `type` field from `struct pll_clk`
>   clk: renesas: rzv2h: Add support for enabling PLLs
>   clk: renesas: rzv2h: Rename PLL field macros for consistency
>   clk: renesas: rzv2h: Sort compatible list based on SoC part number
>   clk: renesas: rzv2h: Add support for static mux clocks
>   clk: renesas: rzv2h: Add macro for defining static dividers
>   clk: renesas: rzv2h: Use str_on_off() helper in
>     rzv2h_mod_clock_endisable()
>   clk: renesas: rzv2h: Use both CLK_ON and CLK_MON bits for clock state
>     validation
>   dt-bindings: can: renesas,rcar-canfd: Document RZ/Five SoC
>=20
> Tommaso Merciai (2):
>   clk: renesas: rzv2h: Improve rzv2h_ddiv_set_rate()
>   clk: renesas: rzv2h: Simplify rzv2h_cpg_assert()/rzv2h_cpg_deassert()
>=20
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 242 ++++++---
>  Documentation/driver-api/phy/phy.rst          |  24 +-
>  MAINTAINERS                                   |   3 +
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 +++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  53 ++
>  .../boot/dts/renesas/renesas-smarc2.dtsi      |  29 +
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  14 +-
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/rzv2h-cpg.c               | 183 +++++--
>  drivers/clk/renesas/rzv2h-cpg.h               |  54 ++
>  drivers/net/can/rcar/rcar_canfd.c             | 507
> ++++++++++++------
>  drivers/phy/phy-core.c                        |  51 +-
>  include/linux/phy/phy.h                       |  16 +-
>  include/linux/string_choices.h                |  32 ++
>  include/linux/string_helpers.h                |  26 +-
>  15 files changed, 929 insertions(+), 366 deletions(-)  create mode 10064=
4
> include/linux/string_choices.h
>=20

I reviewed this series, looks good to me.
I can apply, if there are no other comments and test was OK.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/192=
6888333

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


