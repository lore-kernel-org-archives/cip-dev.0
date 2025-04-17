Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1154C369CA
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 07:27:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.3212.1744874825439110150
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Apr 2025 00:27:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=FMCKyusZ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1744874806;x=1746084406;bh=hj/ijR786agHfD516moqiEvK4QkbNQCitaYUdZR
	xWdA=;b=FMCKyusZlWu/IBg+yNyq1kQuAB2q7e+Jn9dpy5UPH4xoKBEzRyJ1Xzo+2dRxsD/XkltJf
	UixmvJs1itUOVVqXGHq2fV2X35r3aYdD9vtBpbBCHzEhXRM0sJv5roxBdM7VGF6Y4t3kaO1fifwbZ
	1fLxu2UF6Mpi+L2omkw1IDEPjtDXMzhBaoL/QRw5dgrVLwDg0Zi/jQ+FL1gWb9VzWCaBvUzRnXFrx
	I15yeuEw4I/uZ6xmqqLFM6TRkUco4pMYGiU3ue5OTSlE5ZMznKX+cRZzz0XikvoBSGi7t/E/vmiGZ
	kuO2Q+3L9Ns1B5oLFllazfZ3qSY/vixUfkFgUTlD0A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 53H7QjLM2424144; Thu, 17 Apr 2025 16:26:45 +0900
X-Iguazu-Qid: 2rWhiV7hSWpD12xIaX
X-Iguazu-QSIG: v=2; s=0; t=1744874804; q=2rWhiV7hSWpD12xIaX; m=GnOC7tBV7cZVmcaeNvabFfjNmaVsZxdPrvapmfVqb3M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 53H7QgOD3556473
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 16:26:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S94fCpZqR4rUUT4BZCVFawYqyXGCFEnvPgUBWKA96lThMHM15zbL6j+jxo1MJc9MRhfdaY0e1koDKm0s+/q/uAc1wwBIaiSR3vv8v4c5L6QpUpEWa58GB66k44Ktq2zr2gn7Ry8vUU7syB3TeE/+oCJF3QG37eKkxbM2xN4bF7GvfoXtbp+7MhRHJ/fVy1rlGY8nlawmFaavO3LKK3JrbRCuTK4n7YWnxdz4zfleDmnTjttHBgG6ydcwc6uW6xaS9Wupu7dKiOX7vg0TyX9yOJ+qIk2HEmE6DGtZN/KdLNt1wtGsxSXXvLdIUu+81D7uJoHcAC8P7YEhdU3SLz+L4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNXwDKdxvcq48bbT05tDJveF6EGNbTxrys4PGyRu2X0=;
 b=qPHN7OOpYVoYzkjmRAdPNTac/rAqsT3eTyVgA1+9xhKssE23TXHLaLabvJdwhBeWBuDNlH4RJJ6iVp2QYRkTTM/EvTl2LGCHTcJzoZM/cUeRLpwbxWDWZiAbiot7TrGzbZ2e4ETppm4AisSu1RhnbvoCcKs9dbeBwfcc7zflfF0JPB+9+phmcWjo+k8XCj4a6VFyC2MmZpvq52ItXPkapquWz7WPu+6SsqOlnNlgShJYg2nbeW3vwvO+nsnVcbVzf9F/tyG8pdCncF2ek77R1gU5QsXzn77vxyeLeLbqEJcJur6nzqSR9qPU+hD/2+6wFMLoOm53pdR1PZd1YIWf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for reviews for 4.4-st63, 4.4-cip98
Thread-Topic: Request for reviews for 4.4-st63, 4.4-cip98
Thread-Index: AQHbrq7obcALghp7Y06LG7Q6hgVlS7Ondg6g
Date: Thu, 17 Apr 2025 07:26:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185224CD00C8A85BE5705392BC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1262728637.101069.1744794403686@webmail.strato.de>
In-Reply-To: <1262728637.101069.1744794403686@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8082:EE_
x-ms-office365-filtering-correlation-id: d5b53d67-17b3-40ca-9134-08dd7d812f62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VXQ2MEVoTGhCdk9iWmdmN1pJeFpKNFU1NmNzTUZEeDJNM3YxNWtOY0Zs?=
 =?iso-2022-jp?B?WWRaeFdTSUxxVXpRSUpUQzNxZjJLa2dNWSsxTlJwN3FtZVRqMGxEZHRt?=
 =?iso-2022-jp?B?VGpyVkh0Mk5OWS9qUjhaRmhGbGtPdUNDNTFwa3RUVE5ZNVpnbzBEQXBZ?=
 =?iso-2022-jp?B?cnZtMzNiNkVPZ1ZOVFZoUjFvY1BDVGxqUGhHZ1NZaE1KSDZOVnR4NEc2?=
 =?iso-2022-jp?B?TkNaZWVvcjgySUdpdU10S3VxY2V5VlNtOUxvMEFOZmdycWlDL21wN3ZW?=
 =?iso-2022-jp?B?cXIrb1FXY0RWa3RISFRHQ0M2eEVWL1FrKzdtMEtIbThndUl3S0F0ZGJH?=
 =?iso-2022-jp?B?RlNNTWhjY1p2K0Z2ZkR0LzJ0S2hhRHUxQUxzSlIwbG0wSXU0dlA2OGZl?=
 =?iso-2022-jp?B?ZkRCd1FmeG5jSDFaUUxLak1xK1daZGUzV2F6YWFDOGtZQ3piVFJQWTA5?=
 =?iso-2022-jp?B?VXJyNC9XQy8rVTVJZTBDdFFMSFd1OEkrdDBMWkxoeXpxNHdzbmpIYm9C?=
 =?iso-2022-jp?B?RU1CaSt5K0xjbzF2TjZmWVEyVHNNdlZSWkg2cnpXYU1qa2w5UThyYkRF?=
 =?iso-2022-jp?B?Q205Ym5KNEE3QUZVdEpxczdoS0NvOTdWY3hmd2E2NXBIb2tsTGxVNHVY?=
 =?iso-2022-jp?B?TFAvSmlYZWNLZnRkaUdRVTdyaGR6N0dac1pzM0g4UWxMUVZ0VkU4cHAz?=
 =?iso-2022-jp?B?QzQ0L0NJaCtodWsrMkRtMUVtRTJxV1ZkRnVMSzlFcTk2QkIyN3pjMWVN?=
 =?iso-2022-jp?B?a2l3V2VqeU1aVURBc2MyaXRsdStVMnZ0L09tQzl1VUY0UDNxakhuUU5I?=
 =?iso-2022-jp?B?RVRtUTFaMzVIUm5Mc1B5NWlVbnRERXNkbnQrb2M5b2M0TnZQZW1YYUQw?=
 =?iso-2022-jp?B?OE1KK3p0NnRxUjBMOHErcnR6TUFRVXFTTkhKbnBrbDFqb21tUTZtbHo4?=
 =?iso-2022-jp?B?UFN6bTlyaGFGN1JVbHhRNXFBUU53QWE1eDRlUU9jczZ0RkJHd3NtMm14?=
 =?iso-2022-jp?B?eUoxeVU5bklLVDRxQXpZcGJ1Vk1IendZQ0xvMGxzTkQrVlZsSVdPbVE4?=
 =?iso-2022-jp?B?bjRveTBSYVEyRnIyZ2I4aGtLeDByN1F1aGozaHd1eWJpVm9EZEM0MXlB?=
 =?iso-2022-jp?B?eXl3TEJmM1F5UGY2b25kd1FRL1NBVlErVGttUVhaZW0vbFZWZ1BMYWo0?=
 =?iso-2022-jp?B?Y0Q4MnpBMk5STlJGMElWSnFSbUQ2N2lua3Y5Rk1hblljMHlHUndQMnll?=
 =?iso-2022-jp?B?ZytMOW1kQzc1Mk44SS9CYnFJcXFlQVVCS0dTU1VGektUcm14N0pUdFVh?=
 =?iso-2022-jp?B?QzFMVjBON1VTYWlDYnA1UmlqWTJZNmd5OUNNRVc4Y3VaR3ZUM0ZCYmNU?=
 =?iso-2022-jp?B?UWlZMFBEYkVaaG44Q3hUejB0RTMyaGxNMTQ5eWlUSCsyUVNxeHNNaVJq?=
 =?iso-2022-jp?B?dWwrY3pvYVhBd1RPci82OVZlUEF3K2sxUW91Y0NmQTVZRjBwUzN5QWR2?=
 =?iso-2022-jp?B?QWhEVTZMbmhmUmFSS1NmNDdKdlg1NiswRlJlVG50RUFkcHU2TU02dS9U?=
 =?iso-2022-jp?B?bHhLNUkxYzhBZ0xYdHd3WHNIdmdrK1lhT1RtMVk0blRDMWdzMmZVSTA5?=
 =?iso-2022-jp?B?TDAvYjBCNStxRGVpc0FKTVQ1ekVjWEw0SnNrT3UreVhzdU01Q0R3UU05?=
 =?iso-2022-jp?B?OUwwUHZNZURTNWdPTVRyWjgzRUgxSGtjeGdZMUk2bWlaMlpLdUV3UitF?=
 =?iso-2022-jp?B?aGlOMXcxTU1GOHkvYituV0VtSjFpcUtIUnZhMlJsUEc3eElXUmdyUGJp?=
 =?iso-2022-jp?B?MmUzeVNHL1ZiTEFuYTc1bWh6WDVVYytCU3hhT2hYWi9pdkRGckVrbVNX?=
 =?iso-2022-jp?B?WGdVeXhiRTFMOWVMaXZzbjlJT29MUDRoNUZmL0o1MFN0azl2NDhFdUpu?=
 =?iso-2022-jp?B?TWVwTEUwK0NaTHdGRHJkVWlhUmZSVlNSelRUbnFzRkZ2VnZhcUFid2h3?=
 =?iso-2022-jp?B?ZkY5c3MxU2M1czRYTEd0b2M2SWN0WjFETzRNTUFGUzE3WVFWa3FNMEdl?=
 =?iso-2022-jp?B?cnJMeGxWOHVkWkg2MnltR1JNV0w1VHhEdm9hQ2wrRXVWYlFaWS9KZVNM?=
 =?iso-2022-jp?B?YUNvdXBLcXlKNGtKc2tPT28yZVhGazRCQWYwZDByNGxTenJpWWhwUmcw?=
 =?iso-2022-jp?B?cjhVPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZFpUSEN4Wld2emJIOFNZZnJuQlc4SGxDaTJlOUlJenNMWmhYWm5SVW5L?=
 =?iso-2022-jp?B?YjZBcS9rY3VsQUpIR2ZpaW4xbW0rQzB6ejJpcmNjVTArampFdC9sUStW?=
 =?iso-2022-jp?B?VXpXUDVRZmJxbVMvTTNrUmcxN2h6Y3NrTkcvOUplUkJLWXFtbk1CZ29y?=
 =?iso-2022-jp?B?WTV0azI2REVCemFIZlFSWWtVelI3dmpKYjhSbjB3ZExscklEMGNVQjA4?=
 =?iso-2022-jp?B?bzZWaVhYMTJINGhFMmlMSTluRjd0L2N6Rk1VOGlwaUtZTjRSZE94eVgw?=
 =?iso-2022-jp?B?NXRPcVFLRlJYM1o1TUQ3Ti9HR0loYTRza0NiRXk1YVoxTDZkdXRuWWVB?=
 =?iso-2022-jp?B?cXk5VkVPTTRhOGhoT0NudmgxNldKb0NWUDhSZjlpZlB6UHBiNFZHdEhP?=
 =?iso-2022-jp?B?UllxbC9KSmdqVCtySElPaTFzUDNFeGU1cS9iTWhuUzdZVWlFWGhrWWNB?=
 =?iso-2022-jp?B?R3FBUlVaSWw5OFZwWXgxV1NaNGJVVnBEbjBkUUxxaUtsK3F6VDh5NkFn?=
 =?iso-2022-jp?B?ZEhtTUVmSk4vRFo5YmRIdVpWUDdFTUoxd2MwQ2QzQmwxY0FWM3crMzNL?=
 =?iso-2022-jp?B?cFlkQjY1ZCtLaEtPT3c1eS9UN2NSSEU5bkRvNE1ycG5WOGUySG5kNzl4?=
 =?iso-2022-jp?B?eGFUWWxJQlZHVUlzL1hPSkt3R0Fadm1OY1hMdktudkI4TkdmRDhScHpG?=
 =?iso-2022-jp?B?YktnRi9mSEIxSGhOM0tLL1VhcHRKenUxQ2RUVVlNVDBHL3RPQ2R0R2Zk?=
 =?iso-2022-jp?B?MmFON1ZzNFhJMlY3ZFZRMVA0cnJIQ2dZZU1nYW1UMDYrdDl2MzQvaE5O?=
 =?iso-2022-jp?B?QjkvTFQvNHpqZ3ZqaVV0WnVlL3pZeE8yd1RuVmJGUXg2R1N2M1hMQlll?=
 =?iso-2022-jp?B?eEo1cmxDSENRUTNtczFmanpQRk1aVzlFeFVwUndGOHdrUXhoTEJCL2tK?=
 =?iso-2022-jp?B?ZXJFdDhvdkhrUnhkY3ZudXdBK1NmeFVNcGZlS2szMDd3K1NGNVBXMFR4?=
 =?iso-2022-jp?B?Q2lIaGtrQXJjQlhtdklGZW1mTlNnM3o0TVVBOHhSTEdTTEVNbkt1eEVG?=
 =?iso-2022-jp?B?UFhjQ3ZFa2pHVkFqaFREVjJLNXo2UUNSeDJQVEFIcWo2Yml1cGQ0RFpy?=
 =?iso-2022-jp?B?S3RQbStUZUV4TGtzOWZUdWZ0dVFMdnpUZHQwT1ZCN1QwckFVZUNwQjd0?=
 =?iso-2022-jp?B?QXpZeHVYV1I2K0M4eWR0SUt0K2ZrU2FHMi9QUUgvMDlQbm03OHNscU9H?=
 =?iso-2022-jp?B?ZGlFdlJYaXp0SXJlMUZaSWppay9xdTh3WXZTWDREQWdqYW5kWUo4Qk9W?=
 =?iso-2022-jp?B?MTl4YnZIVTNTdWdyaCs5TUlZRyttOE1lNEJwVDA5WEtPaTRZSTB3aXhl?=
 =?iso-2022-jp?B?SzVuMjREM1dKRlFZdGs1KzB4QXoxWlpjc2tiRE1HdGI1UWt6enNTUHNn?=
 =?iso-2022-jp?B?N2gwQjI1Y3dwNTk5N2NxWDZDMTloNmxSVm1jeFRybHROV0dleFlCNmJQ?=
 =?iso-2022-jp?B?OGkvYjJUTVQzWFlZNXdWVE83TUF2MHBlZkc1YVhrMWlEd2xuUmkxN2U2?=
 =?iso-2022-jp?B?TXRWQXozOSs2a055R0ROc2JMSjFNM3VhaU1GSGlkQ1JOcmN4OWhUbCs1?=
 =?iso-2022-jp?B?c25aVU95d01tVGdoSkhWMm5QTFJOQWgvVFR3UCs4aHdFTmRaNkZCU2xG?=
 =?iso-2022-jp?B?UDB0V0JnRUN4RDdGdExIZmx3ZUFDWkpWUFRzbXA2NzZLVWNMMEJIVWha?=
 =?iso-2022-jp?B?R3VPN2xSK0M4OXhBQm93SmZscFN1QlZtMkNSdGhUVyszQXY4cVNQWk1y?=
 =?iso-2022-jp?B?eXUvVVUvbTk4T2NCY0VwQkhZSmtxQXlFL2lGcWhxQzJQSEdQQXNaNFFZ?=
 =?iso-2022-jp?B?WnlPQ2tWaGRVb3VIL3FGaHZEd2MwMXpaaEw5bmlUQVBnazNIV2gydXdn?=
 =?iso-2022-jp?B?dEJxQjBITmxjMnlZYU9KU21CNGlIZU1vanlKSktrSDNXb3FwN2UrSjBC?=
 =?iso-2022-jp?B?NGJaSnhhcHl3RkR3L1AyUTBjc3hjMnJYczhMeTdsOTdFQUNxOW96cGx3?=
 =?iso-2022-jp?B?RDFKejhSNlkwVGZSR0dsMG9DOEorNmR4clpJQlZaaXdzWG14MGJnOHox?=
 =?iso-2022-jp?B?aUs3RjJtdEMvZzhVa2RWQlEvYVdoMEkvZ2ZIYVEvdy9HQzFNalZib0tY?=
 =?iso-2022-jp?B?am94NEpNYzNUcmhXNUdLNkM3ZENMUkxLYU5RTmYxanBDRzRKSi9sQzVs?=
 =?iso-2022-jp?B?dlM3S3pUYVN3MHFCbFBBVHpmMWdBbUhQbVU2aGlhOFpZQkJmd1lwM1FQ?=
 =?iso-2022-jp?B?b0d6VG1mQXB0MEJrNE5QYUhobFJWanMza0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b53d67-17b3-40ca-9134-08dd7d812f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 07:26:35.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5QMRtat0+7//GbldItD0/YvaMRa63qD3ZoSiykKjl+ldkWSVu1t/roBNMe9tNLNB4vEcmBEUVoEe4rEH+CBavghWGhhMXpCLbd5n7YbCsNUxY6cGiXoqe2xZDIaj+4x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 07:27:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18519

Hi Ulrich,

Thanks for your work.

> -----Original Message-----
> From: Ulrich Hecht <uli@fpond.eu>
> Sent: Wednesday, April 16, 2025 6:07 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.=1B(B
> =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co=
.jp>
> Subject: Request for reviews for 4.4-st63, 4.4-cip98
>=20
> Hi!
>=20
> Here's the manual backports for the upcoming 4.4 kernel release. As alway=
s
> they can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.4.y-st-rc
>=20
> 2a7220968ef9 nilfs2: handle errors that nilfs_prepare_chunk() may return
> a19568ab17e4 wifi: nl80211: reject cooked mode if it is set along with ot=
her
> flags 8004e7ee132f acct: perform last write from workqueue
> cb22ed056a63 pfifo_tail_enqueue: Drop new packet when sch->limit =3D=3D 0
> 91ae321630a0 geneve: Fix use-after-free in geneve_find_dev().
> 89f949a9d75c ipv4: use RCU protection in inet_select_addr()
> 69c4abc86ee6 ptp: Ensure info->enable callback is always set c9bd974f385b
> tg3: Disable tg3 PCIe AER on system reboot 08f7a045863a usb: xhci: Fix NU=
LL
> pointer dereference on certain command aborts 76519d4fbe4b net: rose: loc=
k
> the socket in rose_bind() 719d7bc8be0d rdma/cxgb4: Prevent potential inte=
ger
> overflow on 32bit
> b3b9ee117046 team: prevent adding a device which is already a team device
> lower
>=20
> Thanks for having a look!

I reviewed -rc, patches look good to me.

Best regards,
  Nobuhiro


