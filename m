Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78A6D2127C
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 11:14:04 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.web11.46634.1729163636046257700
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Oct 2024 04:13:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Q5cFdlxd;
 spf=pass (domain: renesas.com, ip: 52.101.229.14, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wF3SavYijtSdt9dKRV41KdWwOkr/ZbagXe9v0EzHmsffP8tDwK8yrLgrrqKseWFwbmyuXe9W65S4LT1llYAR2cTtzbIEhdXC2BL1IphrSG7z3rrQzI84CaV4eMlSE0PrE7ld9pv+lN9eimm1mSzyQyM5FBa2R5yIETeJDGDdpSs4xdDTjZXgXq5irYKBv69MXzb53sd4nL2nWZkAU9saUxiVUip0tXGzlENwjCHbo1VSrRszvmRUSFcK/Mg+j6LFos1HtVUGrzNdDa4d30Re2B1KAcQ2I7JhMO+TOB4d3CHIERTGO4bof8tmgFvm8aO6C6XlADJ9bo5egYn9vNG9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42eIFePuFurjuKJC7vQma2a4Yagx/yk3Mfxrfq917MU=;
 b=RRrJ3i5FwPjJNjC2rlV5Fk73KfZdFnYEwwt+BD3b5d/Opdw6XKFltyjg8onzI5G1PIg84/Y5Fc1mxW0xQX9BcpjSxsdYQMQcTZBatNEm6O2/hzJcunCAqLEucf/ohzY0XKAG57d2fxWI4LdFnK0T2YlZ4MiOR+ijS+vaXHlYjZFE0q71XS/Q18BxMfYRkCxWbvvLc0HSgRhx/2Pq1N54l4z6GhfzCUPJE5967x05npBzTliH3RcLYAOrcjExdvoDTXkDv5EnVDQ5vjrpQ7onbeQHU2si2X7wQ7V/v2OfGIz6CKD8Odsz8bvPwHTTPh/nSBH4Relw6aegnYEcQblskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42eIFePuFurjuKJC7vQma2a4Yagx/yk3Mfxrfq917MU=;
 b=Q5cFdlxdHV/p2+z98+Gq29BkVmPrQD1HCPCVpVYBioymg8FQkZF69x0Nhg4Zib0WcDDyQNLjFwNRiOzBQ2+d1j/TDfgwWsI7iVNOJfbirW+z6V1FqKdTnOvk+R7fWy8EPT3GSmrQkNsMwYy6sunvc04DOtPvo9eIY2zuwzL9Md0=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TYCPR01MB8485.jpnprd01.prod.outlook.com
 (2603:1096:400:156::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 11:13:50 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 11:13:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] lab-cip-renesas offline
Thread-Topic: [cip-dev] lab-cip-renesas offline
Thread-Index: AdsaKgOu1+fH4iYTQ/ipcTRm11rUKQAGNb8wASdLSIAACdxZAABEGayAABttayA=
Date: Thu, 17 Oct 2024 11:13:50 +0000
Message-ID: 
 <OS9PR01MB12389A2AC9273E41030B2D285B7472@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <17FCBD68B18E5703.22523@lists.cip-project.org>
 <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <Zw4uFWi6kWekKeCd@duo.ucw.cz>
 <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <CACe6DC6p+G47ET8XSrk4X+WpjuKKqQZkC8p+jj8WUg80At2XqQ@mail.gmail.com>
In-Reply-To: 
 <CACe6DC6p+G47ET8XSrk4X+WpjuKKqQZkC8p+jj8WUg80At2XqQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TYCPR01MB8485:EE_
x-ms-office365-filtering-correlation-id: add7fac3-6e02-4cfd-1e28-08dcee9cc759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZWZaMkx0RmZsVHBPRnFHeHRaQlFCWjIrZWFBNTF4TDZhSnlCR1NFZ0w1cmQ0?=
 =?utf-8?B?WEFBT3h3ZlB4N2xTODN6Yng4R3FPN003K3N4b3N6UTdpQmhEQVd4Y3NveU1a?=
 =?utf-8?B?aml6a0hsaU9mWW9iSVUrbmVZV2NEK3puOWRRMzkvSkozT3FBWm5yMmdRTk5v?=
 =?utf-8?B?R3ZIcUhJUVFRSU1tZVh6d0hyOFhuNzhIVTlIbkdoRXc5cEw0MHFMZlhxcUdX?=
 =?utf-8?B?cjZaRHBvcHh5TjV6WC9NUFpNTkVTVzFXNzVXZ3pCUEhINjVEVy9GaUVOWE1K?=
 =?utf-8?B?K2h0Z2M5UlRmdktWNUlCY2J4MWc5YVVqUklwdE9aUDErVnlYbFNTak1adGp4?=
 =?utf-8?B?SE1JNzZuWWtwUzN2Nnh5eU4vMlFGd3ppUkZEZ2liOHYySlhiVDZwRmloUERn?=
 =?utf-8?B?Q0pVMnBxRXBRTmJ5MktSeGZrMmNtL25OOUpLaFk0U1JVdzlSTlFSUE5JQ2Vz?=
 =?utf-8?B?enEzK1J6UGJTcmFTRVBKZ2lqa2FTdzE0KzNFYjVjcXVjWU1EUDNyZEhnbXNE?=
 =?utf-8?B?Tk1DdVZzQzZ6UnVsdzN0RFlQUm9PcmRKVHR4TFA3SXhwTVhad0VKeTBURG95?=
 =?utf-8?B?S21lcmJPRjJUZDVRNyt2TWYrU3BOTWNDNEhIcStzM3pKUU5ZY09NdUV1S2w3?=
 =?utf-8?B?RlpyZmV0MFljNUdPa2VaZ0RCTzJXQ3F2NTNNbENVRWlHNU5TLzRTNGk3YUMx?=
 =?utf-8?B?S012dEtycUdLMnhXYzlBV250d0htRUFlS01xc0VJVkk4TUcweWlDZkRwcDFt?=
 =?utf-8?B?RmhoRUg3OGdBbG1VQWVUQll1aEt0d0p3RVNMei81cW5ObEFyVG9CTDRYalJr?=
 =?utf-8?B?SGFOZVBzVS9NbEFiN2szVjNLTUt2dkJSeG1HdWQ0Vytya2xkSmFydjlIZ1Bw?=
 =?utf-8?B?Ky9FVTVnd3ZJeFJhTG14MW1jNVlNeUZ4S2ZJSjd2UThENFJCczVXSCtQRVAw?=
 =?utf-8?B?anBVbWV2WjdnTnNPNVBYMUhyTjNrdnZUSVB3OGJZSk41ZHlacWRGRm9PdlM3?=
 =?utf-8?B?Vlo5R09YZFRzazhTQ3dDb1RkR2gvUzVCQWpMc1pUc0lmZHdpMHFkbytwTlB2?=
 =?utf-8?B?dGhwck9nRy9iYWtvcW9OZDFFOEFRejNDeks0RHFHRFpWTXVhbXZoTDNTcDJj?=
 =?utf-8?B?RkFqZGxlbmhEdUJNQThYc0w5UlVya2RFOUNGLzJQLzRDMTlTV3dnV1BpQ09i?=
 =?utf-8?B?dmxNcWN1aWl2VTZ6RlFjL2lPcHdhVmFrV0JFSGJ2MG9PQlpFNEtqTkJldmJy?=
 =?utf-8?B?Y0VacG1sUVRpMEV2NEN0cDl6c0pZaXJVcjV0eVI2Q0JoUUlOTm55bkc4Ujc3?=
 =?utf-8?B?RDZ3YVJtcWNHQUF1d3FmZVN4cjd3dFg3bmR6aXc1dVFXOExndnhYa2Q4anRt?=
 =?utf-8?B?MU1BL0hCQXRUWXYxa0x5TkJuT2xiaXZ2MTZkdVJ4a0tQWE5MNWxncThRa2xm?=
 =?utf-8?B?Y2ZadEk1Z1JiUmI3MlNkVUE4NnZmMFpBQkZLYWpsd1JXTzJIck5aVVpkL1pn?=
 =?utf-8?B?eXJJTzJacjZEcXBEOUJYVEphcUFzTm5lWW1LWDEwU1AxTUpvb0FFaVR0VDY4?=
 =?utf-8?B?THd5K3JwQXY2TlZyQmorN1pGTmpPL21LNE11N2hIaEI4ZE5pOU9Dbjc2VlA3?=
 =?utf-8?B?aHNlSE5WZW1sdlBoQjhWRVRoSy93TVRNaG5GRTNTYmk2Vlp3WE9HMzJ5V1BY?=
 =?utf-8?B?bXFoYVE4OFNmTVBVb2xnUjhrUm1xTitIWkpvVVU2T0QzNlcrQ2tmMEU5bG9T?=
 =?utf-8?Q?c3jjD9jJKeLVC4oI57YrehJjyVOabVSwni3CLqN?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RWFuNElXdXg5OEx5N2xFS3NDYTZGNjdEKzFSSllIaFdFbUxybXF3WTJtUkhR?=
 =?utf-8?B?Tm4xdzVtZnJZS2RmK09nd3RNU2tvb0t2K0hTU1RmenJkcFpmODlYV3VMTVVW?=
 =?utf-8?B?N3J3YzdiVUVBUFZYZXA4U0dVS1M5KzVJTEZkT3gyRFJmUFQzRWNqQXpjS0h2?=
 =?utf-8?B?K25MWU1nMzV4WEJuQTdVeXJIRTd4Y1pHUjVyVEZwOVp5VG8yTjZyR3ZYTXhw?=
 =?utf-8?B?L2U2bnNocmE2YXFDZHdNdDhWcVY5RTFxVWdmWFNEdkZXNlVmcHpmcjdKeG1O?=
 =?utf-8?B?WFZKakFURHNqVVFCbWRJd1lSa2VhNlVWRjFXUjJrT2k3czhBZkZldVFNTEtP?=
 =?utf-8?B?MVEwbzJqYXg2c3F3SWEvUjN2SUt0bnpxOEhhM0xqRkJkdXdjT2Q1VXZDaWky?=
 =?utf-8?B?RGZEZ1JrNTRoUGhDSEJReHVJSU5uVjB5WGpmVkdLRDVEZFVCMXJxajVWN1NQ?=
 =?utf-8?B?aVJVWGpFcU5kaDhETTVhd09mSHFvMWdWNitxdjhadFczOWJtL0ExZ1lOZFRk?=
 =?utf-8?B?N21tdVYyeC9uMkVicnByUjE5b1BkU3lPS3EyQjJweGtqcEtHT0xXaW9YZDhr?=
 =?utf-8?B?VDQwM3M3TE9oeUZjeFlJNE5LUXdlaVZjWUU5S3MrNG5oL1ZWZkcvZXd0WWdQ?=
 =?utf-8?B?cUEzT0U4NGZHSjFuMDBlb2tza2NWQmxDVnFNekRSNmJ4d3A4MWFBN2xqMFNo?=
 =?utf-8?B?YWx2Q2t5OEtIQnhEOEhLZ3JKN2ZZYWJSVGx3bVY0Vm0zOU9ZcG54Lys0bDBn?=
 =?utf-8?B?bHhZbzZNWVA5dWgzV3BnSHlabHpMYnR3Uk9GbllMbXllYjlxSGtqS2lKaklJ?=
 =?utf-8?B?L3BHcGVtRDAxdE1WSGJZb0JTbGpHVjN6Q1Z0ZWtXbERhWEYvYUd3MnlmMDFD?=
 =?utf-8?B?Ny9QWFluSC9HMGwwSE9jRDhrS016VkRydjFVRmhxM0FVNW1FbW1zek9scUpm?=
 =?utf-8?B?cU5Sbnk0SXVwZlJXVU1tU0VVNmd6a2tVUHJLOEZzVnhtSWl1V3JkYTVYcWxR?=
 =?utf-8?B?UW1FMEF4V2FRZDJ0dTIrdWpubHNiYXhIclZLbTV4OXVtSVBzSW5TVEJ2dnFX?=
 =?utf-8?B?a1VBOXhWeXpaN3R1N3YrSWdCelFCK2lxZUoxa0lyTHpOVStuZnhQMGlxc2VP?=
 =?utf-8?B?TDBnV2xaUk9iTW56KzNncW1haThMZmRtWW9DUWxVbUhFbTFSa2lYYjVyeXNo?=
 =?utf-8?B?SU0wTjgvZ0lLcnJ3WjNmM1krWHpiNUlSSjZMVTNhVXVhYlRCek16QnlHYTV0?=
 =?utf-8?B?Q0QxblNpRHNxR1dhakJzWDhwV0FPbFVQSUxodTVJMTg0RmlaZlp4TFM2T2lk?=
 =?utf-8?B?SEZDVE1YcHphYmt0Q3J1MEtWV3I5bWRJUnpDb2lwQnBWbnc1ZkhIYTArakds?=
 =?utf-8?B?T3J1c3oycFFyUUVvc0d4a3NWclZaeFh1N0FzaFVhb0tJSTRMb2d6dExQMHRZ?=
 =?utf-8?B?UytXZWNQajFxSys4K05EVEpkQW55a3ZxdzBlNkV3UUx4WDJrVkRyNllYTlJB?=
 =?utf-8?B?MU5tUjl0UjJSc0lQQUhJbXl6Zk1kWHdvNkJVMS9GTjlTZVQ0M0oybitPd1hk?=
 =?utf-8?B?NkpkcDlNY3BkMXJaTlhTNjg4NjlFOEdQR0dUWENkYzN4bmgyckEvU1BWZU5O?=
 =?utf-8?B?NjFLQ1R0MzhZUFA1WEdQM1VOeWM1MmEyUndaR1dZaUxhSWlmOVQ4WVBmb09G?=
 =?utf-8?B?bU5pK3hpZ2M3TjZjOXE4QlFJb3plb2tKT3hSOCtkMldHV1VhNlR1aXFITUpy?=
 =?utf-8?B?WjA2dmNHRnIyZWtHaU1LWkQ1NFhoNC9iZHYza1hYOTNJbURXUXNRWEY2OUVs?=
 =?utf-8?B?dTFCMG4wclRld2Z4SG1XelV2cnl5ZFFQblc3U3A5YzNxQ01ibEpDS0pBTlR0?=
 =?utf-8?B?dVRLYnVaQVlNbXdIR1YzU2xpTk03MkhIWEdzWjY5WEhESC8xaFZIOE9qWXVy?=
 =?utf-8?B?Z0l1RkRFelB4blNsSHo5VmJQeFZlTVQrM3Q3VWo1bGxBTEQvdU5XZlFjQlhC?=
 =?utf-8?B?R3pJdEdWbGdpbWYrZ1ByYXp4V2N5OWRzM2R5SXAwYTlXK01JeXpMcnh3MlZD?=
 =?utf-8?B?UU41QWErZUxHa0hXVnVCTk9vQ0FJd2xIVjVjRkE0Q01PNGlMZG5ab2Y3WE84?=
 =?utf-8?B?NWg4UXNkTURZTVlVSmRJSXU2ZDZLN0grRWVOM3RWaU9zRlc1MUk5bjVoRjZr?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add7fac3-6e02-4cfd-1e28-08dcee9cc759
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 11:13:50.5956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbkVdm7bz8iKOzAMhSR9W3VAUGlYgHoqYxDIsrm6arp4fSNMlJuGto0F01fKWM8V5h0Ix9AfsocwnufqmR4+KVqxd+KERz5Z66Fyqv0TzI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8485
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Oct 2024 11:14:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17050

PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBOb2J1aGlybyBJd2FtYXRzdSB2aWEgbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IDE2IE9jdG9iZXIgMjAyNCAyMzowOA0KPiANCj4gSGkg
YWxsLA0KPiANCj4gPiBbMF0gaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9k
ZXZpY2UvZGUwLW5hbm8tc29jLQ0KPiAwMz9yZWNlbnRfc2VhcmNoPSZyZWNlbnRfbGVuZ3RoPTEw
MCNyZWNlbnRfDQo+ID4gWzFdIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIv
am9iLzEyMDUyNDUNCj4gPiBbMl0gaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxl
ci9qb2IvMTIwNjE2OQ0KPiANCj4gaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxl
ci9qb2IvMTIwNjE2OSNMMzk0DQo+IGBgYA0KPiBbLi4uXQ0KPiBib290eiAweDAxMDAwMDAwIC0g
MHgwMjAwMDAwMA0KPiBTT0NGUEdBX0NZQ0xPTkU1ICMgYm9vdHogMHgwMTAwMDAwMCAtIDB4MDIw
MDAwMDANCj4gWy4uLl0NCj4gYGBgDQo+IA0KPiBsb2FkIGFkZHJlc3Mgb2YgRFRCIGlzIHdyb25n
Lg0KPiANCj4gRG9lcyB0aGF0IHdvcmtlciB1c2Ugb2xkIGxhdmEtZG9ja2VyPw0KPiAgIGh0dHBz
Oi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9sYXZhLWRvY2tlci8tDQo+IC9j
b21taXQvNTE3NzM3Zjc1YzU1NmI0ZDIwNGQwZmUyNDQ1YzIzZGFjYmQ0OTRjMg0KDQpSaWdodCB5
b3UgYXJlLiBJJ2xsIGdldCB0aGlzIGZpeGVkLg0KVGhhbmtzLg0KDQpDaHJpcw0KDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+ICAgTm9idWhpcm8NCj4gDQo+IDIwMjTlubQxMOaciDE15pelKOeBqykg
MjI6NDYgQ2hyaXMgUGF0ZXJzb24gdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA8Y2hyaXMu
cGF0ZXJzb24yPXJlbmVzYXMuY29tQGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz46DQo+ID4NCj4gPiBI
ZWxsbyBQYXZlbCwNCj4gPg0KPiA+ID4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiA+ID4gQmVoYWxmIE9mIFBh
dmVsIE1hY2hlayB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4gPiBTZW50OiAxNSBPY3Rv
YmVyIDIwMjQgMDk6NTYNCj4gPiA+DQo+ID4gPiBIaSENCj4gPiA+DQo+ID4gPiA+ID4gbGFiLWNp
cC1yZW5lc2FzIGlzIGN1cnJlbnRseSBvZmZsaW5lIChzaW5jZSBsYXN0IG5pZ2h0KSBkdWUgdG8N
Cj4gc29tZQ0KPiA+ID4gcG93ZXINCj4gPiA+ID4gPiBpc3N1ZXMuDQo+ID4gPiA+ID4gSG9wZWZ1
bGx5IGl0J2xsIGJlIGJhY2sgb25saW5lIGxhdGVyIHRvZGF5IG9yIHRvbW9ycm93Lg0KPiA+ID4g
Pg0KPiA+ID4gPiBBbGwgYmFjayBvbmxpbmUgbm93IDopDQo+ID4gPg0KPiA+ID4gSSBzdGlsbCBz
ZWUgZmFpbHVyZXMgbGlrZSB0aGlzOg0KPiA+ID4NCj4gPiA+IGh0dHBzOi8vZ2l0bGFiLmNvbS9j
aXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1zdGFibGUtcmMtY2kvLQ0KPiA+ID4gL2pvYnMv
ODA4NjA2NzQzMw0KPiA+DQo+ID4gbGFiLWNpcC1yZW5lc2FzIGRvZXNuJ3QgaGF2ZSBhbnkgZGUw
LW5hbm8tc29jIGJvYXJkcy4NCj4gPiBXZSB3ZXJlIHNlZWluZyBzb21lIGlzc3VlcyB3aXRoIG90
aGVyIGxhYnMsIGJ1dCBub3cgd2UgaGF2ZSAyeCBkZTAtbmFuby0NCj4gc29jIGF2YWlsYWJsZSBm
cm9tIGxhYi1jaXAtZGVueC4NCj4gPg0KPiA+ID4NCj4gPiA+IE90aGVyIGJyYW5jaGVzIHNob3cg
dGVzdDphcm1fbXVsdGlfdjdfZGVmY29uZmlnX2RlMG5hbm9zb2MgZmFpbHVyZXMsDQo+ID4gPiB0
b28uDQo+ID4NCj4gPiBJbnRlcmVzdGluZy4NCj4gPiBUaGUgZGUwLW5hbm8tc29jIGRldmljZSBz
ZWVtcyB0byBiZSB3b3JraW5nIGZyb20gYSBMQVZBIHBvaW50IG9mIHZpZXcsDQo+IGl0J3MganVz
dCB0aGUga2VybmVsIHRoYXQgaXNuJ3QgbG9hZGluZy4NCj4gPg0KPiA+IElmIHlvdSBsb29rIGF0
IHRoZSBqb2IgaGlzdG9yeSBbMF0gZm9yIG9uZSBvZiB0aGUgZGUwLW5hbm8tc29jIGRldmljZXMN
Cj4geW91IGNhbiBzZWUgdGhhdCBpdCdzIGJvb3Rpbmcgb2theSBmb3IgdmFyaW91cyBrZXJuZWxz
LCBidXQgbm90IGFsbCBvZg0KPiB0aGVtLg0KPiA+IG11bHRpX3Y3X2RlZmNvbmZpZyBzZWVtZWQg
dG8gYm9vdCBva2F5IHdpdGggNi4xMi4wLXJjMl9kM2QxNTU2NjkgWzFdLA0KPiBidXQgbm90IHNp
bmNlIDYuMTIuMC1yYzNfNjQ4NWNmNWVhIFsyXS4NCj4gPg0KPiA+DQo+ID4NCj4gPiBbMF0gaHR0
cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9kZXZpY2UvZGUwLW5hbm8tc29jLQ0K
PiAwMz9yZWNlbnRfc2VhcmNoPSZyZWNlbnRfbGVuZ3RoPTEwMCNyZWNlbnRfDQo+ID4gWzFdIGh0
dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzEyMDUyNDUNCj4gPiBbMl0g
aHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTIwNjE2OQ0KPiA+DQo+
ID4NCj4gPiBLaW5kIHJlZ2FyZHMsIENocmlzDQo+ID4NCj4gPg0KPiA+DQo+IA0KPiANCj4gLS0N
Cj4gTm9idWhpcm8gSXdhbWF0c3UNCg==

