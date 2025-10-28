Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC4CCCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 07:39:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.6253.1761637183436697674
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 00:39:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=heIWGKtI;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1761637162;x=1762846762;bh=
	R4/Vi8nhIy2c/Fxl4O6FF1JmhIYpyfhqF24IOtJH2os=;b=heIWGKtIW21uZQaHmzp4/E6cxRv94l
	tl5C8Vb88ApJeG0gfnN6qVHz8q2xywLXIAShzwPQPZnfzJ1XYJu46QAoIwln0LKa//yIGp3JRvD7O
	+xzdFaN/Eyf2B3kk8KlS5iC0Wlr1gTwtkJnakRlYqRjSReNHNcH7vn8W+4ZDbivPbSAhfxNWpczR2
	TJOk8sAmGWUsnqCsmhrH5lOx4I2bE1IUA6rFlUU01LUDMouhXEhPMt0CL9KcyRHvPXzpBkzmUDtig
	jNSdF8fZ1GFFppHbfEKv1pTq8mAkEOi46XK4u4pe+GWo+ef+EyinHwx7rlpn3uM61YU7AwJHp5XqV
	FS9A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 59S7dMHk2534694; Tue, 28 Oct 2025 16:39:22 +0900
X-Iguazu-Qid: 2yAblOJGmdggwDfyDo
X-Iguazu-QSIG: v=2; s=0; t=1761637161; q=2yAblOJGmdggwDfyDo; m=mh7NFDx6a/IsEhfheATiJNx0KkMhCDClgViwcYr78C8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwj1j4GsCzyPQ; Tue, 28 Oct 2025 16:39:21 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+fW3JR7tTbMTxaIrP05/Hn3fxMcPQqYhVcIIL2fdNVmTvf/0DfC6bmFq5boAJAwsbvERbwCwGdTozjiB9w2QkmTevaAjSsAMHOVconIFQMW9nCwzxNOOjoLeFEx1/uLWSPNtLeymCsu/0oNjKAOh856GaTEgGSNbonEEaM55KGqAsbj/vgr/8zGY+99ocA/NAD0Z1lMVOEwWAMVGVuyMgUJEzdc9M8OCdER9ZpF1ao7clqVDllPwTusxnNHBmKWD96ZaBTx6yoASfxu77OX76B97yVctTI/SUOLV0Eam+sl95uG+IreVhxBI8vAVLL6CIk2rXyTVtyUwQb0WBQ9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDkZ/M5tSadqivBhaPK+sdhCyO/JqlV7WJJkhoJ4fdE=;
 b=B1OAVpAEAV8KQstWe8V5E/CZbqA1FllkxXk9bHhLeG6IU1YqodToNna4ykzhWUiseCc8XX7LvxetK1fg5vEQDClL3Iv/iBFpw/ArQln9P1XjH4PyeQFrNbpTt15ml7Y/Iv7DbH91LhQ7LWj35pmkE2zS+z6neonEDDJBGyBj5CWaUSPYxISS+9kRe+5m0Z0mIUxW0ghNde77cZH3WAuOEmBz5QMGIiDVj/HKZaOTDvy9R18SZvIae+Mc9b0KnIYJtQ0KSZA1DApE6QiFhvlDD7PZ6S96eUNToQ+wMY18N55FHFZ65WJMGiQrBaQmpOAcwTUsMcGIHMH5zGsMvDJnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <chris.paterson2@renesas.com>, <pavel@denx.de>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.12.55-cip11
Thread-Topic: [ANNOUNCE] Release v6.12.55-cip11
Thread-Index: AdxH3eNzO7Wc3OYCRQqWQ5T5QTmglw==
Date: Tue, 28 Oct 2025 07:39:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818116B78CAB1336058CFB0CDFDA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB14115:EE_
x-ms-office365-filtering-correlation-id: ed5bd74c-32a6-488f-1593-08de15f51a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Vm01SWpsK0NHRVlqck45alR3UTdRSmhjZzdzaVZQV1lMeitXMFlsbUJJ?=
 =?iso-2022-jp?B?Vk0vZjFjN1dZNGk2SUJuT284Mk9ieWlhUWhnVmJPWkJDRkpkZnYvaU53?=
 =?iso-2022-jp?B?QkxBQkhDZmZBWGRpaEJ6VnVaT2I1RHgvODBTN1VBMTlnUGtPTVBIanI3?=
 =?iso-2022-jp?B?alVxa3VUdm1iOHpEbkh4Y0pYRXNqRHF4cVJxZnlCSTQ0YUh0NysyT3dx?=
 =?iso-2022-jp?B?YjArQXA5UkxkTFg3dlhvaGFkQVlOMk5kZndQZjJ3SVhacnNnbEtQS1dJ?=
 =?iso-2022-jp?B?OVhMU0tydTJPSnV4T3JDenI1WXYzc1duQzlzL2VIWFhJK3FKbFNJMFRw?=
 =?iso-2022-jp?B?RVNLZEhSbVA2d3hwZmlZTE1jOTNBS1ZGY1FSRmNkZXJkM0l6WlhYM2JQ?=
 =?iso-2022-jp?B?eTgyM2U1T2o0aGV5OUNwMVczdHlqK2ptd1VmaUNZVkFkYXpiOVhQcVp4?=
 =?iso-2022-jp?B?VlJDQjFlQkg2K2ZmTzVlWlQ3bm5WdWRZb3M3TXZkSm9Jb1p2Vk5pWERi?=
 =?iso-2022-jp?B?UTV2dTEremxRQkFIWjd3VzBoWmNROW1jMVVxdmFOc080bEFxUFNhVjlR?=
 =?iso-2022-jp?B?R3FCa1NIcHR0aDJFb1F3aG04b0hJaU5mYmllbFBUaXpqWmlLYlNNaWx5?=
 =?iso-2022-jp?B?SDZOZ3lJWDUvbmVCdExCOFFLUnpKemdwbjBNV2VWK2dvWkcyUFlnM1Zx?=
 =?iso-2022-jp?B?OWg0bHhQSlVsUzJVRnFaVVJDMWZrVTQ2WFArVndXWFpmY3JpNVREOXp0?=
 =?iso-2022-jp?B?ZjhtSnhwbENGL0JMYm9lRWszZkJ6b1lGUzlRQ0FGVG5YVDZUOU1yK24z?=
 =?iso-2022-jp?B?clI2aTlhVUhoWHFqMU1JWEFyUG01dHRlR0NUZmxGSXQ1a2tXVnJJRUNl?=
 =?iso-2022-jp?B?emtlMU1QeWVXb0d0elpBdFFFeWFBZlZGdk1ONUREblpWajJKbHNETmpW?=
 =?iso-2022-jp?B?aERDMFpyb2l0OEkrekdHekNFd1BRZkhTMmh3SUZVR0Z6eUR1N0lnQkNu?=
 =?iso-2022-jp?B?NlI2SCtPei9mL1RRZmEwZ3pEVklvb1YxeVNybFh6TGUya25GeVNpMWc3?=
 =?iso-2022-jp?B?eWdiSkhDZ1JkV0ZjdXVyTDFiazQ3T0cyYjZJT0lCbE0rb3ZxbXdITitC?=
 =?iso-2022-jp?B?SjNsQjJ2cUV5TFdzMkEreE9OaGh1MmIwNEpSczFTbUpVcUY1RkVjVkg1?=
 =?iso-2022-jp?B?OGIrS1NYZ3crZmh3bEdsWHZIOXpPMkZ0OGRMVUQyK0lPaURLWmJGbE0v?=
 =?iso-2022-jp?B?V2M3Y0Vma3NFN0diY0ZmcVVXTHE3dlNXaTZjZ29KNDNKMkRFQ2E0a3Ro?=
 =?iso-2022-jp?B?Y3h0aFU0S3kyUnFacVJoY2hld055TFBnbE8zZ0xsMTNJVEJzN2p0bndm?=
 =?iso-2022-jp?B?Mm9OYUJnbnM0TFUvNFZ6TmRoUmhQTEgvc1lyd1RpbS9kZmErWDdsR0pE?=
 =?iso-2022-jp?B?RjQxVW9md2ROUWcxQ2FYRlRYWE9PZm56QkFEcnBSYjZ0RnpJa29hRWkr?=
 =?iso-2022-jp?B?RUl5UEpablBmYThzZ3g2ZVAyRGE1SElyL3NoSkVJbE1lZk10emJsUENW?=
 =?iso-2022-jp?B?S2kzekVRaVlZL0o2alpNTWgxc3RGWDZWNkExaWxjWld5V0RhekdLY3hw?=
 =?iso-2022-jp?B?bVN6RWdjeUlHRHgzc0FiOFlBNmVHVkl5MEJHNGg3ZzVZdzJzNHVSWDRm?=
 =?iso-2022-jp?B?Ty9QSnphaVRwNmU5bkRGM3AvanlUS1JyMXFSb1FsdUs0TVI0VllUWVBL?=
 =?iso-2022-jp?B?NG1iK25sNmFzKy8zUlY4WGFBVzVNbzZJdzBRRnB6MXlDVVFEQ0ZXS1lp?=
 =?iso-2022-jp?B?cjNFKy91dmcwMlZyWE9QVGlpMEFiM2I4cVBPdXZwZ2dMWmlVM25Id3oy?=
 =?iso-2022-jp?B?ek5kZEQ4d0xWZkE1VXYyMHphZmRya3VCRjc0Q3JHbUlHamlxMlExam9M?=
 =?iso-2022-jp?B?cmdkZ2JQRmpiVU9uWGU5dncyeWQ4dDJ2SHlyQW5BTnpub241OFBLOUNa?=
 =?iso-2022-jp?B?MU9iNEZxanVjWTFqU3lrS2U5YjBxZ2tBZ2VpUDRXZlRCczZzRTdBM2JX?=
 =?iso-2022-jp?B?TEFpbnZ4UEtoZUoxQU9zSDBxbUxxZG1nUklrRGF5TnQzaEFjVlpPcTVk?=
 =?iso-2022-jp?B?RzJwcituaGNwcFRUcUgrTy9XZFArQithdEpwL1hBdTdpTUxGRTFVUFJp?=
 =?iso-2022-jp?B?REZoOTd3cStXNFhkTzErcGh1Zy9HMEdF?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZW11YlJjd0pCTmhxdk1Ja1d6SkxMMVk5eFNMaXhQUnlqMUJWOHg5cy8y?=
 =?iso-2022-jp?B?VG9ZcXJrOVFOT1NJRlZRRkRlYnI0RVpjSVVTMUNMZVhsVjV4bkhiMUJU?=
 =?iso-2022-jp?B?SGtRWC9obWRweTRCWDBwL1dwOFA0bTVUSFJUNnJiaEtJOEdCdmdIN242?=
 =?iso-2022-jp?B?cmNQQWJhMmZhT3NpUkx1MDBHeCtac29ySnp3a2kxaEdNNmlxUmE5WGhw?=
 =?iso-2022-jp?B?dldRaUVJU2dHM25XUmI3YitFU0JPSS95VmZFYm1NTk1LRzVHUkowSkhr?=
 =?iso-2022-jp?B?VkJyckpJYW50WDBCSHJRbi91MUNETVFaT0o3L3AvdTRtMXQrSTV0cUY1?=
 =?iso-2022-jp?B?Q0RnSkdVQndRWGJNcSszSDE2R0ZBVW9lMmhFaVpCbkdZWGRrd2duTkwx?=
 =?iso-2022-jp?B?QlAybXR2d0Q5VUtzWjBLNStPM2N5SXY2YUY2V0RrOCszUW92M0Zodk9w?=
 =?iso-2022-jp?B?MExFbUFZMEQ5WlhOekx5aWRLUC9STktWc3AwK3dBTE5mWEdJc3hweFFt?=
 =?iso-2022-jp?B?ZittN0NuSGFuK2RLTVJlemlqZG91cHFyMlV0ZlJiRkRLMkFJZm1FOEll?=
 =?iso-2022-jp?B?dmNGckZYekRYQ1Y2Q2RIbVZIckhzYytXc2Z5S2tucTlyc0k1WWErWUFF?=
 =?iso-2022-jp?B?QkpkT2MyaGNOVjYrNU13WWhhMllyL0tCdS9BMTFhcEJQS0tJVXA4d1hD?=
 =?iso-2022-jp?B?NExRTHJOSTlRRGZyZklGRGxublg0TjJESlFET1gzc2RKTEJSSnBWb0lK?=
 =?iso-2022-jp?B?UU45RVA3cWt3bDdCZXZjTU00TUFlaUtxY3FHQVk0Y1hFOHBDK3BOWEpr?=
 =?iso-2022-jp?B?aGp6aVc0QmI1bnVyRmhMN2dKczQwU0l1dVp2UkpkaVFMb0QrYm5QanRr?=
 =?iso-2022-jp?B?L3piU1VsV09xRzlJaG1oamZreGFMVXZ1bzZvdGtnK3IxUlI0VkxUbEtr?=
 =?iso-2022-jp?B?eWtrY2hhK0IrT2ZHVzVCc2luRWNZb2g1blJHRC9kMUFIRmpmaGNCeTFk?=
 =?iso-2022-jp?B?cmdiakxUKzJQZUk3RVJSeGpjY3Zzbmp5anRYSEc4bGg2UEp4Z3R6YXFk?=
 =?iso-2022-jp?B?Qk12cWx1b0VsREwyS0pHcDcwZXEzSkdUTGF6Z0RBSXdNaExQYjlzVkxL?=
 =?iso-2022-jp?B?Y25yZTdLaFVReXN6Rk5MT0hteS9GL0U3L0VSUFhvcnFoTXRFb1VpUHV5?=
 =?iso-2022-jp?B?clc5ai9VVlBGYUFBZ2RiN0ZQMThPalpUcTFwQjNwMWkvc0dKKzhsR0tF?=
 =?iso-2022-jp?B?K3RBL0FNd0ZHSmxTSmlYQzE5dk4yRXJQSkx0VTZ4enlCK2RsamVaVi9s?=
 =?iso-2022-jp?B?SVlvM2Z1Z25pc25kc3B1cktRRDZ4RzRtcGlIa2ZDRXZwYThTM0hiSFJk?=
 =?iso-2022-jp?B?amJpTXdNZXovbXhhV29Fem9zOHZ4bTNGUk9tWjc1YjNKWmZ6ZmR0cU0r?=
 =?iso-2022-jp?B?SWo2d0pyVVk1aW1pZzQ5cS9WenBmQ2crQ1ljYll4dTFtREVxWHl2bEFD?=
 =?iso-2022-jp?B?RklrM1RBaHlQVWtBVzhsSmxsOUM4RmtDRWg0U1FnK1VQajA0OXlvK29N?=
 =?iso-2022-jp?B?ZjloQjRpTXZMVWJVMGhmQkVtK3BiR3I2UFY4ZmN4SGptVkV5NGR4Y3JM?=
 =?iso-2022-jp?B?enNiWTVLWVQ1bEh5LzJXR05Mclk2M2cxYUZPdVJSMnVsWDhvbUMzTWRr?=
 =?iso-2022-jp?B?Z3hybkR6dXFGMzNXdzF1OHBHZENGYmRmSS9wM3RXenhPZ29jeXlWMXdU?=
 =?iso-2022-jp?B?RXNlOXFudGVITVhoa2hCOVMzd2VDTVRvR3RsdHJzODF5UjNGejlnVit1?=
 =?iso-2022-jp?B?MnZFZUxRVVV1b05ubTdud3I3aDFaajFTTk1ITTk5RGxrSTI2TXBUMzdF?=
 =?iso-2022-jp?B?OWlhQ1dOeUZnVHlWaDdVRU5jNE5hTFphWmJLWHJ6MVhnTTRZY1ZZaHFO?=
 =?iso-2022-jp?B?SHJMOWpRU21oalFwYVNlVi9XQlBac1pJTnNLSitXSFhvRVdqZUFjZElW?=
 =?iso-2022-jp?B?d0ZHSkhtajBoZGNGYS93RTZsQTIyQ282ZFJMYUZMT2dVUU9DcWFrTk9W?=
 =?iso-2022-jp?B?RXgwRWhDeGwyMHdxeEFkMzkrSW93QzF6VXVFZkF2b0ZUd1YyUTR6K0hu?=
 =?iso-2022-jp?B?T3dXT3pVditOZkJvR0JSSDFBWFl4MGlnZUlSTkhGZ2hpdU5SRkVFdWV2?=
 =?iso-2022-jp?B?aWRTOFJBVFY5Tno0M2xZNFRReXlBK0dTbEtVc3VBcGRKN1BUVFJrSG1S?=
 =?iso-2022-jp?B?akZCUDhsODlNdzkzUjBGNjdJQVpjU3NiQ0FHelNOcGlsWFc3SnVJT3pS?=
 =?iso-2022-jp?B?aGE3dDArT2c2T1ZjNVVqUFhuUnNwZVBYS3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5bd74c-32a6-488f-1593-08de15f51a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 07:39:19.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBB30HAlcB//xF6Wvuasl/7CWP7v2hft6+WXN5XwmKLA/EdBZMlJaARSA8OmS3aQC+HoQXRM/STZ6edcWVayHkHCVCRPLe/Gs+eMP04Px/1/ajYxismYh7WPS/o4bY1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14115
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 07:39:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20249

Hi all,

CIP kernel team has released Linux kernel v6.12.55-cip11.
The linux-6.12.y-cip tree has been updated base version from v6.12.51 to v6=
.12.55.

Information about this release is as follows:

  v6.12.55-cip11:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      330e81cffd92ee882cab831898b219e5f15b243c
    fixed CVEs:
      CVE-2025-38105: ALSA: usb-audio: Kill timer properly at removal
      CVE-2025-39995: media: i2c: tc358743: Fix use-after-free bugs caused =
by orphan timer in probe
      CVE-2025-40000: wifi: rtw89: fix use-after-free in rtw89_core_tx_kick=
_off_and_wait()
      CVE-2025-39997: ALSA: usb-audio: fix race condition to UAF in snd_usb=
midi_free
      CVE-2025-40018: ipvs: Defer ip_vs_ftp unregister during netns cleanup
      CVE-2025-40004: net/9p: Fix buffer overflow in USB transport layer
      CVE-2025-40003: net: mscc: ocelot: Fix use-after-free caused by cycli=
c delayed work
      CVE-2025-40019: crypto: essiv - Check ssize for decryption and in-pla=
ce encryption
      CVE-2025-40001: scsi: mvsas: Fix use-after-free bugs in mvs_work_queu=
e
    added commits:
      CIP: Bump version suffix to -cip11 after merge from stable

Best regards,
  Nobuhiro


