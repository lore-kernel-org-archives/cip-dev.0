Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873BDC77B7F
	for <webhook@archiver.kernel.org>; Thu, 29 Aug 2024 06:36:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.6505.1724913385403501830
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Aug 2024 23:36:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=TkVedWj8;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1724913365;x=1726122965;bh=dq
	J4BosDqsQE+9Nb911EEnkUXyzLQViLuBCBLkR84QI=;b=TkVedWj8XcrKljqAk5Bt3K3EBMaRZ4JN
	21FZEjnnLDjsz/3u990QvoZHHV3Aru3KXgUEJTS1eJoldMtMcSztB8NumQYExaiMCE8DpX75HLh6Y
	cmn8JPFuLiJ7BqKKsbq2mKhhpW3B9/hVRxGlRA3hjzbnBL6SZxXq7JggJ1RAbbsY4sWKuGuWnVkW7
	xiqMiezmrtfJgI+L3g0o10GCgN8euu0iSJ92QV69cJwSQoFj+4aNxz5/qID1ZQCkoRG0+hHmVPqlb
	R34NH1ORisIBasRL4dMSXfaroUJcoXQLWFAkyu8WrDbSJd53ZsRjY+9Lo7hHbPzT+9odHHuSiWva/
	xw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 47T6a4DB1958193; Thu, 29 Aug 2024 15:36:04 +0900
X-Iguazu-Qid: 2rWgZF6BSxr0FenCcK
X-Iguazu-QSIG: v=2; s=0; t=1724913363; q=2rWgZF6BSxr0FenCcK; m=sGeGzpyAchiQSatuXSSjBfXvfoNjmiucGvnkYu5OpN0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 47T6a1xw1406079
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 15:36:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbn1sfafg5tLcE5qebvwVVsojvfwGVlyTBh/ZxonhzWJXfaNwmlQJrpSZKxGNTY97XXTFj9FDzjlUNVqvhdYBzR6DlxzKHLtkR5MjpJNk8pZTD6cY4HpxhFmw+G4Lfuvm9S5/270Frpu8F6zuheJ9Ulv7aKg2GcuMDonFfZRX4i8FreRVUGNsJSiujqwv2k07k1wQvYGUJ/NTMQjyomykpWuy64PyVCAhZaH+t9dT3mnXiSmDPkARgivPH0/r+tE+AQDkY+nr48ECxZ8+//Cw12Ej03IHNfpV6tZShxifvmMYCNLdFOVqy50Cw9oHg7h+MQYKTtjSB1CuBoLLZoJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IUreG4xAh07uBWzx0zHi8O833laYJ8tzrXj1O+Vp98=;
 b=W8wjJSV5mQK1m050tn1xVhBBI5MpeBm6GE0zWoShuBfuowjpSAtbLkpS6F0bZqslrpgCjbh7Bz8wl1yNKbnk/3u1knO1K1204dKjODx5vJLy7xdj/wyRzuoMs2paQ3f4azOCf6zFP1blHg1xeCa/NkM3en/hItBcPugHommhq2th3J8JxBcgH0Eeo+b1eLEiH7k4R7zRAJUldxTERgwFZYxtMvsIpARH2UQEV8vyeV1yBiWGpSdSoUkEkw26aS7Ar0FalMhWzjtZG3KxTyBqEyo5y8giKK3/S1FU+4duwXT9yrQAOse4iFjxf9HfHvjkpHS1HZNUj+k9PeQeSDixIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v6.1.106-cip27
Thread-Topic: [ANNOUNCE] Release v6.1.106-cip27
Thread-Index: Adr53HNrXWd0/aOSRRyu5QPE+abreQ==
Date: Thu, 29 Aug 2024 06:35:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388A46989155DAE0B3FA53392962@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSOPR01MB12328:EE_
x-ms-office365-filtering-correlation-id: 9ee340ee-90d8-4628-4b6f-08dcc7f4d779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dmdnZVZmMVF3QU9VNXNmMU14ZUV4VUErSURmV0R5MU5Ta2dEMFN6QTZs?=
 =?iso-2022-jp?B?N3ZEZWVES3VOVEQ5aTdJV2F5bWhvai81RnhDOXBxNjROOXBQaGVyR0Ro?=
 =?iso-2022-jp?B?VXQvMG9vVVBmZGF6Y3oxcEw5bEtxZEZrNWlOOVhDbHJKeVdNUStvN1Rk?=
 =?iso-2022-jp?B?WGJlQko0MmtvVXZicUJ1L3BGQXdHQXllMUNoRVJ1Rkd2RGlSWWNqSFRF?=
 =?iso-2022-jp?B?cndEbmwrYmpZZ01Nc1dqUVNyZ1NwK2ZZd1RqK2gwS295M212ZE55WHBM?=
 =?iso-2022-jp?B?bE9NemRCdlpnVW9HVGx6dkhVeUZQNGIvSnZGa3pFSmdCTHVKV2xPWnJs?=
 =?iso-2022-jp?B?WUM4eEUxSWdBbUt3ekdqQ3BFU1dYc2FIaFBkOFE3VEpIaWpSTytkVWda?=
 =?iso-2022-jp?B?V3NML25qVXZhVWw4SW0xb214QVBSMFdyTVlWcjhzeU9JVVQzNVU3clc0?=
 =?iso-2022-jp?B?VjZYclBRaVg4MEsreHFya09Oc2JOa1BhQTRnbzc1YTJmbkxmYTNvQ0NP?=
 =?iso-2022-jp?B?T2FpRmhNZVV4VjJ4Vlk3bDBJdXpjRTZHQmxqNzhESmhpWU1UMzNiaHVy?=
 =?iso-2022-jp?B?OGFIUElEbVptVEUzOEdWNllYam02eVNNOUFVdzNVMFBwNE5ncnNmRllU?=
 =?iso-2022-jp?B?Y1JZMUVpWDd4a3Qwd2poTnJSUWdmRStLUGNkUURtb2c0bUtnYkh5ek5R?=
 =?iso-2022-jp?B?RTV6MHRFWWR0ZjRBbjVjRXBaczlVSDhLNDVzdlRHcmo1MEVhYy9lejRj?=
 =?iso-2022-jp?B?YUR6bHJtTWZsKy9pckpTUU9sTWRZbXNhVjNpV29QQ0txOWVJclhOcUNk?=
 =?iso-2022-jp?B?eFRuSXFwTitrYUQyWmpZUkkxWmtOZ3FxZTJubEhEdDJWOGVpTS9SS1N6?=
 =?iso-2022-jp?B?WU5yQXE0QXk4L2x6UE1WTGhiOStveUhuYnhSOVJIb1ROS2RTOGRocVR6?=
 =?iso-2022-jp?B?QTR4RTRTU1g3OVAzcmdnd0J0OSsvR1hoalVkNlpreHpUcHdZdTVQNGt3?=
 =?iso-2022-jp?B?Qi94dzN5UnkvYXh3ZTdUeG02OW9SNjI1ZGFCWVJLUGgyV3hEUklIb0I1?=
 =?iso-2022-jp?B?RlNNcldKUmN3SVczVytqUnZZWUFHVll1d3dxZVYzNC9nTU13Mk5ZOXE3?=
 =?iso-2022-jp?B?TWFmQUpqNUtYMzlsZHU5RyttVkl2OGxuNUtBVktUQlprZ3Awa0I3V2U3?=
 =?iso-2022-jp?B?YjFEb21scEpENWg4RkUxZ2pnMXptUmNEZkNTTGF0K0Fhb3lnVDJjdnZq?=
 =?iso-2022-jp?B?cXlwL3lDS2VVY1pSeWozQ1NDbzJyU0pKVlNZNjhXV0hPbWZxOEIvcHYy?=
 =?iso-2022-jp?B?a0xPMkRTV29hL1k4TWppUnZhWTNIVXZuZXFObm00alJmWCtUYUlkbG1j?=
 =?iso-2022-jp?B?VzQ0Vzc4R0VZWFpKUVJONU93TVh4dW5wd3NzU1pZd1IyUCswOFdJNVEw?=
 =?iso-2022-jp?B?eGhDaXlTOFVZcVk2NmttS2Ird1NBY2VvY001RTN6Umg5QTByUHJkQlFQ?=
 =?iso-2022-jp?B?MGJiOWVLcytZeHM1REp5OVRvMm92S00zTkJPY1g1VGJTaG1ZZ3d0bVZF?=
 =?iso-2022-jp?B?UnljcUQ4MW1TVVErNVJBdGR3QjYrd0hOU092R09aV3dnS0o2QytFRnB5?=
 =?iso-2022-jp?B?RmJyQ2pOTVZWekJKN0JFN1A4blFoTjcxVVRUVnlaKzF0NzQzdjRDZzNu?=
 =?iso-2022-jp?B?Nlkrc2N5YWdnNXNhd2tENDNzVExDeHZEeW9PTURCcWVJWU1WQTd5eUNN?=
 =?iso-2022-jp?B?LzllWFAwR1c0VXlTSG5KMEZwbFhGRVhtVnJaRlZjWGw3VjJRdVRyY1RW?=
 =?iso-2022-jp?B?Vm1wTGgxK0FnVXREWlBrUlFWVjRNNzltRkJ6b05za1lTOGFEV3lWY09h?=
 =?iso-2022-jp?B?TUs0UkMyRVBzdktzTGgrWjE2N0ExRkNrU29RdEhnTHBkT3gwM1JTMGF6?=
 =?iso-2022-jp?B?R1p6czF3YzZBYWd1VElMUmkxZG1xOGxEY1VydjBqTjRLNGFBT0cvMUlE?=
 =?iso-2022-jp?B?bGswVmFxeUFpZXdkWXl1T2UwM3RURS9nRWZwMmdNL1IwVjBrYmRYQXJw?=
 =?iso-2022-jp?B?U0dNRHlLUjhVMEhLYjJHdFpsY0xGUTgzZXRvd1RiWkkxN2Z1alBxakYx?=
 =?iso-2022-jp?B?NXU=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V3JLd0NWRE1QVHU0VmxyUGtndVpjUndJVGh6VUc5ZEFnaHFKOWxRNW02?=
 =?iso-2022-jp?B?RzFoQWt1QWo0TWtxSVlvZmZTRkRkaWx6Zm9WancwUUpoOUtrcDl0clMx?=
 =?iso-2022-jp?B?TjlkblViNWlKa3BoZERKQzRuQ0d1cmZDREhoVUFtRklhSFlxeG9lYUx2?=
 =?iso-2022-jp?B?ZVdDKzNCeDRhdncyZXd2YVRiUkwwcjF6VU43R1ora1drOFlhN0VDU3RR?=
 =?iso-2022-jp?B?UkZqNUQyQnp1Y0Z5cmJjbUp1NVRxWm11dkEzSjRjT2hMc3BYRllaMjdn?=
 =?iso-2022-jp?B?a0tZd0VITGhQdjRVcm9KVmtJcjlxeWxFOWkvdTQ0bFE3TjhWLzNESUl5?=
 =?iso-2022-jp?B?elhCK3k5dDhHcEFSdEQ1dnZYTUgyQlJlT2pub0p5RWw1aWVFQVFLRUJS?=
 =?iso-2022-jp?B?WnNReW5YejZTVXFuKzkxR3hqc0VhNkVXRzdvN3duSVRBR2R0N3Zxcm1F?=
 =?iso-2022-jp?B?dnUxQzErcDNmZjNLRGVPQS9ZdHVTVnVlMzBDajE4UXliMkF1K3dLUkZO?=
 =?iso-2022-jp?B?dzVQMDRkYUdLVm5qTXQ1ZDQxQmluZ25tY3ByWGJLeFZtbWU4dllnUWhO?=
 =?iso-2022-jp?B?ZW5nRlBNOXIzSTJsT1RkcGFUT3FIa2dkVjdxbU9EdlJWclVpbnpMdWFu?=
 =?iso-2022-jp?B?dkY4ZHlXaVI1Yy9BOHhTdGJrNjc5ODlVZmdmVEZTeEd2czNmS2FldWs2?=
 =?iso-2022-jp?B?cEpxaDAwVDhMYWxFUVNwTW14Z1pIZnUxc245TTBzSEFhM0QrbDVWcFdw?=
 =?iso-2022-jp?B?V2daRklNVVJPUjBnQkxTV3Izcm14bk4walZrT25TSGpDdFoycHFVZ2tJ?=
 =?iso-2022-jp?B?T2JUc2QvWVpXYkxrdkVwTjFKV1RVWFQvUllkSm9sM0hndWN6UDlZVFZH?=
 =?iso-2022-jp?B?bFZQaU1RdFB0RkY1b1VBdXMzcE5BTVhiWXpxOTljRUJHZGM0ODJNd2Zh?=
 =?iso-2022-jp?B?ZWlRQVFNRmkzU1ZPTFlkbk1qUTArcmFOSVR2Qjc3RDBVSTdaUTB2dGN5?=
 =?iso-2022-jp?B?cVJ0cnVBeFRYM2FDVTZhV3ZDQTFVMmZoRFRIMkpOeWMvengxWDFiTncr?=
 =?iso-2022-jp?B?L2JWNjRKZWNuV0lhMGhPbm9jcjRNVlpVYVh4UUZNTVVYL1oxNGpKWjFl?=
 =?iso-2022-jp?B?d0NtK0ZLczNkeCtnVGpWTWd2REwxVkgzUndEbUoxdGNHdEVjd2RXb3hy?=
 =?iso-2022-jp?B?T1RQQzVleVNkZ29lcU5tSzVUb2JqdkY5SmVwUDIxLzVpUkNETk9XVTdY?=
 =?iso-2022-jp?B?ZXJoY203cVc5aXBUMWFhUWpobzRQQ25SNU9PcTlScVB3Sk1CRzhDMStn?=
 =?iso-2022-jp?B?eXdQenFuNTBNU1VjVEI3NWhGMU9ZdGFwSE9MckhDOU5hVW9sdTBQVlg3?=
 =?iso-2022-jp?B?ODY3ckRqQlF1TWtVa29JUy9ZTW9nN1Urc2xaSE9Oc21FWGxRS29jc29o?=
 =?iso-2022-jp?B?eUYvZUdoV2l1Q0JkY0RLRlZkeUp2b3FrYytlRFljTUY4dkRXQXdaTzNl?=
 =?iso-2022-jp?B?Q2xkdGVxbFIrS3p0N1ZnNkdCNE9MT3F0SW1YenNTaTRQVTAwc05ocHVM?=
 =?iso-2022-jp?B?RENMQkp4bVFSZVpoTW1JK2lrcVUzNnJOWmh6c3FOako0SVZITk1zTVRU?=
 =?iso-2022-jp?B?Q3R2MUxCbnFKcWIwS3ljM1RQNnlDek1lYUpjc0RPOExvKy8xM2l1K3ly?=
 =?iso-2022-jp?B?b0RuYXNINVByWHBzM1VwU3BicFZlM0U0LzlRa01LbHNzU3VXN2VtMGFY?=
 =?iso-2022-jp?B?M3pmMlAzb09xVDN6dk82SnZiVUR0Z0wwdlNYSkVXU3IxZlZoMk5vS2VY?=
 =?iso-2022-jp?B?aWN2emp1dlRablRVZmNMV09BdXFFUmlPRHVrVHJvUmN0N1FnREswK2wx?=
 =?iso-2022-jp?B?NDJuelduWENDV3BHTk1ZM3I3ZTZXdkJmOE1tOHhCRERzU25WY3RVVDhi?=
 =?iso-2022-jp?B?R3pCMEFudWppUGhId0FsaURkbWpxWkxwb2lqL0d3amhiTW1JQ1ZoS3Jh?=
 =?iso-2022-jp?B?cGdLU3ovUzhKN09CWEJJdnRiN09yTHV5MDB2WGdWaStkZ1U3Y0c1a1dl?=
 =?iso-2022-jp?B?MDNYVk1NSFZ4aW9aWnhhci9GNmlCM2t1eU92aytPUHhlalFabmNLYlIx?=
 =?iso-2022-jp?B?a2tnSkNicmNJS3h2TXRyeW8ySnozb2dDbDdtSWMvOThYVEdmREZDREN2?=
 =?iso-2022-jp?B?SllKdzAvbU40SUxoV2xucW56RDN4d1ZpNENKZE1JQW0wUUluUkM0ZFhS?=
 =?iso-2022-jp?B?MmtnUkxUZHorM3lXamlucFNZZE5TSmpEZDFhUHdPcEliY0lET25rMXJZ?=
 =?iso-2022-jp?B?RzNCSnVVTmo3MmJJQ3VWNEZRbkdiWUs2MHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee340ee-90d8-4628-4b6f-08dcc7f4d779
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 06:35:58.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTh8TGl51Nkxh/dO2wkIbFURIYWJuZQe1O/qkEt7RRcytrXgavvdOCX7WgX25+1ekSry1ImeOQcTkkTghor4t/UnTxhFJqLkNv1F4nmPALvgRLwWSHyC15NgXRuww5VC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12328
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Aug 2024 06:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16830

Hi,

CIP kernel team has released Linux kernel v6.1.106-cip27.
The linux-6.1.y-cip tree has been updated base version from v6.1.102 to v6.=
1.106.

You can get this release via the git tree at:

  v6.1.106-cip27:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      c6754a08d6ade6b805a900d638135722720e73f2=20
    Fixed CVEs:
       CVE-2023-52889: apparmor: Fix null pointer deref when receiving skb =
during sock creation
       CVE-2024-39472: xfs: fix log recovery buffer allocation for the lega=
cy h_size fixup
       CVE-2024-41042: netfilter: nf_tables: prefer nft_chain_validate
       CVE-2024-42114: wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM va=
lues
       CVE-2024-42258: mm: huge_memory: use !CONFIG_64BIT to relax huge pag=
e alignment on 32 bit machines
       CVE-2024-42259: drm/i915/gem: Fix Virtual Memory mapping boundaries =
calculation
       CVE-2024-42265: protect the fetch of ->fd[fd] in do_dup2() from misp=
redictions
       CVE-2024-42267: riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fa=
ult_error()
       CVE-2024-42268: net/mlx5: Fix missing lock on sync reset reload
       CVE-2024-42269: netfilter: iptables: Fix potential null-ptr-deref in=
 ip6table_nat_table_init().
       CVE-2024-42270: netfilter: iptables: Fix null-ptr-deref in iptable_n=
at_table_init().
       CVE-2024-42271: net/iucv: fix use after free in iucv_sock_close()
       CVE-2024-42272: sched: act_ct: take care of padding in struct zones_=
ht_key
       CVE-2024-42273: f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is vali=
d
       CVE-2024-42274: Revert "ALSA: firewire-lib: operate for period elaps=
e event in process context"
       CVE-2024-42276: nvme-pci: add missing condition check for existence =
of mapped data
       CVE-2024-42277: iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en
       CVE-2024-42280: mISDN: Fix a use after free in hfcmulti_tx()
       CVE-2024-42281: bpf: Fix a segment issue when downgrading gso_size
       CVE-2024-42283: net: nexthop: Initialize all fields in dumped nextho=
ps
       CVE-2024-42284: tipc: Return non-zero value from tipc_udp_addr2str()=
 on error
       CVE-2024-42285: RDMA/iwcm: Fix a use-after-free related to destroyin=
g CM IDs
       CVE-2024-42286: scsi: qla2xxx: validate nvme_local_port correctly
       CVE-2024-42287: scsi: qla2xxx: Complete command early within lock
       CVE-2024-42288: scsi: qla2xxx: Fix for possible memory corruption
       CVE-2024-42289: scsi: qla2xxx: During vport delete send async logout=
 explicitly
       CVE-2024-42290: irqchip/imx-irqsteer: Handle runtime power managemen=
t correctly
       CVE-2024-42291: ice: Add a per-VF limit on number of FDIR filters
       CVE-2024-42292: kobject_uevent: Fix OOB access within zap_modalias_e=
nv()
       CVE-2024-42295: nilfs2: handle inconsistent state in nilfs_btnode_cr=
eate_block()
       CVE-2024-42296: f2fs: fix return value of f2fs_convert_inline_inode(=
)
       CVE-2024-42297: f2fs: fix to don't dirty inode for readonly filesyst=
em
       CVE-2024-42299: fs/ntfs3: Update log->page_{mask,bits} if log->page_=
size changed
       CVE-2024-42301: dev/parport: fix the array out-of-bounds risk
       CVE-2024-42302: PCI/DPC: Fix use-after-free on concurrent DPC and ho=
t-removal
       CVE-2024-42304: ext4: make sure the first directory block is not a h=
ole
       CVE-2024-42305: ext4: check dot and dotdot of dx_root before making =
dir indexed
       CVE-2024-42306: udf: Avoid using corrupted block bitmap buffer
       CVE-2024-42307: cifs: fix potential null pointer use in destroy_work=
queue in init_cifs error path
       CVE-2024-42308: drm/amd/display: Check for NULL pointer
       CVE-2024-42309: drm/gma500: fix null pointer dereference in psb_inte=
l_lvds_get_modes
       CVE-2024-42310: drm/gma500: fix null pointer dereference in cdv_inte=
l_lvds_get_modes
       CVE-2024-42311: hfs: fix to initialize fields of hfs_inode_info afte=
r hfs_alloc_inode()
       CVE-2024-42312: sysctl: always initialize i_uid/i_gid
       CVE-2024-42313: media: venus: fix use after free in vdec_close
       CVE-2024-42316: mm/mglru: fix div-by-zero in vmpressure_calc_level()
       CVE-2024-42318: landlock: Don't lose track of restrictions on cred_t=
ransfer
       CVE-2024-42320: s390/dasd: fix error checks in dasd_copy_pair_store(=
)
       CVE-2024-42321: net: flow_dissector: use DEBUG_NET_WARN_ON_ONCE
       CVE-2024-43817: net: missing check virtio
       CVE-2024-43818: ASoC: amd: Adjust error handling in case of absent c=
odec device
       CVE-2024-43823: PCI: keystone: Fix NULL pointer dereference in case =
of DT error in ks_pcie_setup_rc_app_regs()
       CVE-2024-43828: ext4: fix infinite loop when replaying fast_commit
       CVE-2024-43829: drm/qxl: Add check for drm_cvt_mode
       CVE-2024-43830: leds: trigger: Unregister sysfs attributes before ca=
lling deactivate()
       CVE-2024-43832: s390/uv: Don't call folio_wait_writeback() without a=
 folio reference
       CVE-2024-43833: media: v4l: async: Fix NULL pointer dereference in a=
dding ancillary links
       CVE-2024-43834: xdp: fix invalid wait context of page_pool_destroy()
       CVE-2024-43837: bpf: Fix null pointer dereference in resolve_prog_ty=
pe() for BPF_PROG_TYPE_EXT
       CVE-2024-43839: bna: adjust 'name' buf size of bna_tcb and bna_ccb s=
tructures
       CVE-2024-43841: wifi: virt_wifi: avoid reporting connection success =
with wrong SSID
       CVE-2024-43842: wifi: rtw89: Fix array index mistake in rtw89_sta_in=
fo_get_iter()
       CVE-2024-43846: lib: objagg: Fix general protection fault
       CVE-2024-43849: soc: qcom: pdr: protect locator_addr with the main m=
utex
       CVE-2024-43851: soc: xilinx: rename cpu_number1 to dummy_cpu_number
       CVE-2024-43853: cgroup/cpuset: Prevent UAF in proc_cpuset_show()
       CVE-2024-43854: block: initialize integrity buffer to zero before wr=
iting it to media
       CVE-2024-43855: md: fix deadlock between mddev_suspend and flush bio
       CVE-2024-43856: dma: fix call order in dmam_free_coherent
       CVE-2024-43858: jfs: Fix array-index-out-of-bounds in diFree
       CVE-2024-43860: remoteproc: imx_rproc: Skip over memory region when =
node value is NULL
       CVE-2024-43861: net: usb: qmi_wwan: fix memory leak for not ip packe=
ts
       CVE-2024-43863: drm/vmwgfx: Fix a deadlock in dma buf fence polling
       CVE-2024-43867: drm/nouveau: prime: fix refcount underflow
       CVE-2024-43869: perf: Fix event leak upon exec and file release
       CVE-2024-43870: perf: Fix event leak upon exit
       CVE-2024-43871: devres: Fix memory leakage caused by driver API devm=
_free_percpu()
       CVE-2024-43873: vhost/vsock: always initialize seqpacket_allow
       CVE-2024-43875: PCI: endpoint: Clean up error handling in vpci_scan_=
bus()
       CVE-2024-43876: PCI: rcar: Demote WARN() to dev_warn_ratelimited() i=
n rcar_pcie_wakeup()
       CVE-2024-43877: media: pci: ivtv: Add check for DMA map result
       CVE-2024-43879: wifi: cfg80211: handle 2x996 RU allocation in cfg802=
11_calculate_bitrate_he()
       CVE-2024-43880: mlxsw: spectrum_acl_erp: Fix object nesting warning
       CVE-2024-43882: exec: Fix ToCToU between perm check and set-uid/gid =
usage
       CVE-2024-43883: usb: vhci-hcd: Do not drop references before new ref=
erences are gained
       CVE-2024-43885: btrfs: fix double inode unlock for direct IO sync wr=
ites
       CVE-2024-43889: padata: Fix possible divide-by-0 panic in padata_mt_=
helper()
       CVE-2024-43890: tracing: Fix overflow in get_free_elt()
       CVE-2024-43893: serial: core: check uartclk for zero to avoid divide=
 by zero
       CVE-2024-43894: drm/client: fix null pointer dereference in drm_clie=
nt_modeset_probe
       CVE-2024-43895: drm/amd/display: Skip Recompute DSC Params if no Str=
eam on Link
       CVE-2024-43900: media: xc2028: avoid use-after-free in load_firmware=
_cb()
       CVE-2024-43902: drm/amd/display: Add null checker before passing var=
iables
       CVE-2024-43903: drm/amd/display: Add NULL check for 'afb' before der=
eferencing in amdgpu_dm_plane_handle_cursor_update
       CVE-2024-43905: drm/amd/pm: Fix the null pointer dereference for veg=
a10_hwmgr
       CVE-2024-43907: drm/amdgpu/pm: Fix the null pointer dereference in a=
pply_state_adjust_rules
       CVE-2024-43908: drm/amdgpu: Fix the null pointer dereference to ras_=
manager
       CVE-2024-43909: drm/amdgpu/pm: Fix the null pointer dereference for =
smu7
       CVE-2024-43912: wifi: nl80211: disallow setting special AP channel w=
idths
       CVE-2024-43914: md/raid5: avoid BUG_ON() while continue reshape afte=
r reassembling
       CVE-2024-44934: net: bridge: mcast: wait for previous gc cycles when=
 removing port
       CVE-2024-44935: sctp: Fix null-ptr-deref in reuseport_add_sock().
    added commits:
      CIP: Bump version suffix to -cip27 after merge from stable

Best regards,
   Nobuhiro


