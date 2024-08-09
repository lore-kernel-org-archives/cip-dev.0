Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469E5C52D73
	for <webhook@archiver.kernel.org>; Fri,  9 Aug 2024 08:41:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.79646.1723192856445417132
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Aug 2024 01:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=r6Xu97Dk;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1723192836;x=1724402436;bh=CG
	tGQMlz5C/i0DE29sMoQqSNmgPy0QbMHb9LBoNW9lg=;b=r6Xu97DkIFxIdcLU68kzAlFcXXsuJAG/
	s27S0UgCF5jG8hioBWIDGi3B+6ooRkPR5+OasSwZ2Wg8yZo0eqHR6+YT4ZAc4XDsHy/yLvYZdmgAz
	XQGOXWGwx1/GAOX3zFUs2yNooZcr2RDMMBMG46xN4A3Tas9qB20TnaLZoT0Jpi9dZXPMy0aay2Wgp
	I2tCPn76P/OUOXhQrhjHEdK5CDdy4UuqKBWa3sKjo2n2jZyBlabcWE12B9l7z7B2RP9+Nbn7vYTRx
	8e5/Wh3DAHQVEbSBAkxWo4XlFfAYnK0Lv/L3k+1ghs0GVLe4ldbX/i2ZGvBqfuOi14UYBUg7dtXcw
	vA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4798eZPE1571569; Fri, 9 Aug 2024 17:40:35 +0900
X-Iguazu-Qid: 2yAaEcf46hTCJsHoQ1
X-Iguazu-QSIG: v=2; s=0; t=1723192835; q=2yAaEcf46hTCJsHoQ1; m=dqA/QeW8aa6S/3RaGV5Ly/5lNeVKN5WS4gImkqg742U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4798eW4O2226571
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 17:40:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXZGT4v1An4a3qlvo3aM8ucy8+DsdinWYuz3T1h6K925Iqna0PWeu3v87+kB2X8LcKsZ7GKeqjl0DgeV1cWAmBHzBm5WGGnyHEuFIoqr2q/0e/2enYerqGUEE5WKccBmV3h/ydK/gWSxJJuRpxvx2bayI0ngEz8q+g8K7i/XEoSjX6Ktmz1c2gw5MwdLLXCtEiGQyj9x1iGd/DomijDinJJoBAfZXzyK/AwpJRRyIqIZWVGfo8E/+s978xNLN6ST5rcPNghWFgf73f2jBo4wcfQbzLGhwnCye9VyxIiMWm4161/C3mwB6yBDrWbnEfdhbGZXtStuzcIQ+4Z0wbq/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnSItxKORCw8kj2QqSR33NKQWKqQa+CTAZfZ3t+oXEI=;
 b=WFtoVVA+MpH5HZuVCLRgcnmldznk9dydfUwfUT/Pff0q8jNDW/sp//r+e1dZokksOzcunkP33HpVMiJBxkzwwsFpi0oEpuqpQA22nP8S81havQ7WQVXj1mY3e3fwNIzjokZezhZURxGRgoHM/gmhEhCp+StU0JCafb9ZAx7+/SJbjp9k3/QtZ1bt45U2zwMWmxviUh8q6lOrqpRTnS3EFhGVFrZXX/kgDgK2U1YQbtuJAbJ/oOcJqHkKsgNTfJN2CgsS9kVn0KBsXK+7O2H2ef/bUGWWdbEukNUP1le8WLAf7VsQ+JD2nbFwou0SwfmqMr/pi535k+g53q77w78YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.223-cip51
Thread-Topic: [ANNOUNCE] Release v5.10.223-cip51
Thread-Index: AdrqNz3THXHlg1lMTBCmS55VU9keLQ==
Date: Fri, 9 Aug 2024 08:40:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63887DCF9F2F6CB68BFD718E92BA2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB7281:EE_
x-ms-office365-filtering-correlation-id: 750bb164-f701-4a69-36d0-08dcb84eec2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WHp2VkNOQ2pkakQxajh4ekZXQm1XLzRZdnhZOWtpTjZGeUZ5UEZhTjVQ?=
 =?iso-2022-jp?B?NTgxbmlDcTNkYTNRTUQ2U0RsQW9ReGdlM3Z1OExnOEFvZ2swK2VGQWNH?=
 =?iso-2022-jp?B?RHovQ0lSQWdMMHI5UnZTVTN6SzdLRUJkNFozVU9ZcGRDaUZXQVNMaXJ3?=
 =?iso-2022-jp?B?TlJYNUhYK1FhcldnSnJUK0pWSnJNQTFyMmFOaHJUNFNMcENxVmpjZ2dk?=
 =?iso-2022-jp?B?NnJObkxSbTB1a09MSE14Vy9kcXBSVE5EMk84Qm85WUtWQ3lwUCtYVUpm?=
 =?iso-2022-jp?B?dVMrZlhObFNQVkVKUUxqZHBwcTJMa2M2ZkZOZllxR3phQThqakhtSno4?=
 =?iso-2022-jp?B?NTRULzV2ZTgyVFVZWWxJaUJsYUZ2eXdicWZQcnNtNlh4YjFiRWV6Zk5N?=
 =?iso-2022-jp?B?akRwYnNtc0FYdDh1Y2Y2NTQrQmx4WVVoYnk0TlV6VUNYdWhUNXFEd2Ro?=
 =?iso-2022-jp?B?dG9JYlk1ZlpmbGpvK0k3VytUbnpwRk93dy9vZU1hUUFwREVKR1NkK213?=
 =?iso-2022-jp?B?UThmTENQRkdFS2s4WmxZOXY5WnVFOU9SR0R1ZFF0Z04wS3Y5bzBvT3lT?=
 =?iso-2022-jp?B?Um5zQkI1MGpPK3hFMks5Wm9nMUNSR2xoVHdFUC82MlZGTFBxcjVIcnln?=
 =?iso-2022-jp?B?ZnlFRXJxTjdIenpORjQrWmNzbVB4eHpONlBVRldlTGdwT2VCNEZJWmdR?=
 =?iso-2022-jp?B?RTNHc3lYSURmZVUrMGFhSHkvRzk2UURXOW96WDdBcWNNSlEzNWt6NEQ4?=
 =?iso-2022-jp?B?MHV2OWIvOGRzK3U0UVhjeUxKYWRHUjNBTjU5TEpsTDBqSERqbE9CdEFG?=
 =?iso-2022-jp?B?ZndZUGZFOWFSVm9nZFpVOEwyVm5jWWJuSWp1OGI1dStEamc5R3gxZkNl?=
 =?iso-2022-jp?B?a1M2Vzl3V0JFVjI5RnJid0pGd2lyeFdnYmdBNkRnYlpHZ2dTRjdkUW9G?=
 =?iso-2022-jp?B?REFmQkI3aXBDVEJDREoydGlZb3piaXNhVWt0V05McEk0UU9IUnovRUFh?=
 =?iso-2022-jp?B?SnF3Nm45QTFlWU1BWnkyUFB4S3RLSTZZL2dOUmZlNk1tdEtEL2E5TFl0?=
 =?iso-2022-jp?B?QTRKRXFpL0I1dTlJbUlFbkNUZ2F3WCtGaHNJQjFoWWZDTFQrMUZ4NHBC?=
 =?iso-2022-jp?B?bWxLTG5vZGdhck8yMW13SnYxbFRiMEU0am1ocWRVSEtuNy9BQWxxQTlE?=
 =?iso-2022-jp?B?V1pXMzRtZ0s0b2hFLzFtS1VwdGpva0NZNGxqdFJHZmN6Sm5RL0ZHaTJB?=
 =?iso-2022-jp?B?SUZxV3NjSVcxT1VIcVFlVFkrY3RDN0pmdngyb0hPY2swQU9wWDB6SEVm?=
 =?iso-2022-jp?B?d090NW9hZGt5WThCREZPN1I5WEYrbzBPSzYvUWxJcmN3YUszT01zK0NH?=
 =?iso-2022-jp?B?Ykd4TkpiMExNQ3JXNGIrNUY0OXpwVjgrQlZTV3ovSUhRVlBUY094WEdT?=
 =?iso-2022-jp?B?dkZWUUlJVVRIeFJXRng5RUIrNGVWVHl3RFdIZkx4MnhvbmV6NytFbmkw?=
 =?iso-2022-jp?B?SWpHQjFXc29CK2ltVC84SXN6VUZlV1g5UHVrQlNnU21nem5VZjdkKy9H?=
 =?iso-2022-jp?B?cVpNR0ZZSFgxbVBmYlNpcFk5L2NYY2c5aGZYcFl3cGNtMm9hNi8xZ0ll?=
 =?iso-2022-jp?B?UExvVldwVktPM0lGYzdiU2kyOTJhUGV4cTdkdFFsdDNXZXZ1SFo4aXZh?=
 =?iso-2022-jp?B?OHFsODFqL2RoNm4xdXN5Skltdy9RY0ZzNFhVTXBvVE1rYkg1b1c4TkdO?=
 =?iso-2022-jp?B?MzdGaGRpN1htNXEyMkV6ZFBLcVl0a25DVVBXWlYzdDAyMW8yR0QyWGdX?=
 =?iso-2022-jp?B?MUQ1b2VISi9JRWxRL0gzbmhVanV3U2h1NEk0OEdxTDJQSUxMTUdDc3Np?=
 =?iso-2022-jp?B?SmFDSndFOEx5MlpIWFlHU05rY0MrWmVmN0ExS3MvZUR5Z2M1M3ZyeHIz?=
 =?iso-2022-jp?B?dklUb0FsNmdWS1dWYXY2SVlOdWhFQ2ExMThXUFAxS2U5K041MFdSWU1m?=
 =?iso-2022-jp?B?S25yNVJqejYrTTlCZjE5RlRYL1VrNm1iVlhaYmpyUG1QQ3ZTbDdLUjJr?=
 =?iso-2022-jp?B?Zm9GODN5UnduQTZleTVmWFNyNGZSV01LWUFsYjY1dlFPZHpwVzZ6Ly9V?=
 =?iso-2022-jp?B?N3k=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SjcxRlRENVgySytZRWRkUXM5L0YxT1RXcW5iUDBaT1ZzOFRkbXVzYVdy?=
 =?iso-2022-jp?B?K3FObjdsUUhGa2hDNURvbFJPMlZ5TCsvN3Bwc3V2TWdpdnZzRGJVcHdr?=
 =?iso-2022-jp?B?Y3A2a2ZJcStUQW11Ukg0SmM2R2dXRlJ3K01UNy96KzE0V0JzQnJObHFx?=
 =?iso-2022-jp?B?VDVsek4raHFwMk9KNkoxME1pd1l5RHBua0FaZnRhZVpIcWRoOHBnUG5W?=
 =?iso-2022-jp?B?R0RHTWw5QXBjOUhiVXlsRCt3M04zRHJPa1VQMzduS2pJQ2tCUDJNU1dm?=
 =?iso-2022-jp?B?R1pPVThKWmcvY2l4SGlzL1ZWSG5oc21jM3ZqcmVsMitZcUF0S00rVy9x?=
 =?iso-2022-jp?B?dEVQUGNnSElHYXlVUEExOGM0eVd4SHFUVHIzZHBhYXpvZHhMWlZaWElx?=
 =?iso-2022-jp?B?SU15QnVjN2U1ajIySWxnSzhZTTlnU2tWQW1PYVlqOGVRMllDSmY2Wnp3?=
 =?iso-2022-jp?B?a2FYclVpUlpIa0RZeitMbmhrYjZESEZaR0RVTnlRMFp0L2h2K3ZYQm5k?=
 =?iso-2022-jp?B?bFJmMzBKUVlRekFmN3pFMXRieTJsdlB2OTFqZ1I1bTJuSDNEVEQvUGVQ?=
 =?iso-2022-jp?B?TThsZmxnMUtDcllkTHpqbHl5enUyc1d2Q0k1QkEzMUh4Uk5DWk1rTCt5?=
 =?iso-2022-jp?B?WCs2K2paNFdKNWdSdGtUTjNsUWZDWEVHMXNmWHlqdGFJNmpvc1FqU21L?=
 =?iso-2022-jp?B?dUJZMEtlQ2pNbGl1VmdZSjRrRlpodFZNRWlhNmNaV2c0Z29BZ2dMRGVF?=
 =?iso-2022-jp?B?dGFxUWtMSm5hayt1Wks2NmRQYWpvNExSQ2U3QUpKdkNKUjd4OU5td3Nl?=
 =?iso-2022-jp?B?OEcxb0tLbnJNbDBnOGwrSnlXK1RPUURoS29EdGF5dXl5aWg2K1QzOFE2?=
 =?iso-2022-jp?B?L2c0QW94WXhQa3FQSkRaZGlQd25raTAwSStaaTBvZXJoRCtLS243SnlS?=
 =?iso-2022-jp?B?eVMycy95SmFmazBVcC9wdEVWTHpyZFRLQnd6K0J4a0Z5Q2xjR1hxdUlP?=
 =?iso-2022-jp?B?RURzbzZQK0o5UFV2V1dpMGY1NC9YU01LNm5OTXcxcFBpem85VTlkQnVY?=
 =?iso-2022-jp?B?ajZDZ20zYkdrZ1BIaUsrQkpNWUw3dWdUbTBqdG9ScVh4WHJpQTczNmp0?=
 =?iso-2022-jp?B?NFhVUDlRWWdScTZLZ0hsYVlTS1V5VGRtbnhHNklXZjVxYWNsWkxEUDQw?=
 =?iso-2022-jp?B?OGJOQ1lmTTU5bitCMUJRL2RXYXoxTTFtdUQvOXk4TjRJREZ3TzZOM2h2?=
 =?iso-2022-jp?B?TW5mdHRJejArMU1VOGxxVDhibkpEd3k5S1RrRUtxaDhpNmFGNDdQd1kx?=
 =?iso-2022-jp?B?RitHdXdpMUZXcmFmNG5IcjVPWTNJcm1CbVcwRkhUWWM0Q2JlRXluUktC?=
 =?iso-2022-jp?B?ZVByQ0pXUk1wY3ZsOWFHeWRLdEMrSENNWTJsaEZqQ0Rjc2ZCRUFaMlIy?=
 =?iso-2022-jp?B?bDFHdEtGNHRnbTA0bE00NlJwRW55WHdqTitHZWtIRnRMVHh3WjJ1Q21B?=
 =?iso-2022-jp?B?Q2RSNW01czNtWHcxdFpSb3l1ZHdEZ2hPNXU1OU1nSmFSUWRSUlhDU1Fk?=
 =?iso-2022-jp?B?RndQM3JmalBKMlJkSHhuVnFrVlY0M1ozbTIwSU5wZmtUOFZ2dG9UNlV6?=
 =?iso-2022-jp?B?WjNNZ0RwMURRNHE4Z1drN2pndUdKQ0NVY01rdjVZM2hFU200R2VHRWlx?=
 =?iso-2022-jp?B?U002aHppRzQwYkY4ekhzUmhpcG9aSm9WaS9CTGYxOHFPelQvbUFJWGgw?=
 =?iso-2022-jp?B?WlY3cy9OK2hsQm9pcVhPNWIzQk1VN3BhcmtQaWVUcFM1VnQvRkUrbjVG?=
 =?iso-2022-jp?B?MFN2cG0zZDhXazJFNlpRcUtFSGFNOVk0aWN4RFh3T0crbSttNEJPaGpF?=
 =?iso-2022-jp?B?RTJzT0ZnUW03T2hjU3hpYkQ4RTJLRDA2NzhaU3hiTFhXVU9IMnVGRHBu?=
 =?iso-2022-jp?B?N3dxQXpVK1hPYmd1SW5LUDhwU0doZVVBWlJBdXhTUUp3MkptRGFZZkps?=
 =?iso-2022-jp?B?NGQxc2ZDMFVrelk4bDJyUHNqcjR3N1VldlY4UHphZ3ppMFlSK0VaVEZW?=
 =?iso-2022-jp?B?d3RMbmhXQUdKaVFadWIyTVRLLzlpY0FHQUVESjY2aDJtenFISWVDSllH?=
 =?iso-2022-jp?B?aHRnamh6cTZQN3F3d2pYSDZYK2REd2F2c1BaNXNjdHpuRDFGNWRTeWlZ?=
 =?iso-2022-jp?B?STh2L3EwenBySEwrVzFva0JTZVhGWmNUK2diM3NleWNodjJ0a041Mmt1?=
 =?iso-2022-jp?B?aXEyMXd6OEZnbGMzc0VZTUJLaTliQ09UNFoxYU9CZ3JUS2RaQnRJQk5X?=
 =?iso-2022-jp?B?VjgxMjgwM3RkRW1jaitPdXpxbHlVMWFZVWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750bb164-f701-4a69-36d0-08dcb84eec2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:40:28.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N2w4q3T2e0OkXIqD11nsal5sAEMMI1mn11HIjYL/2UBJjR5UorUWKSEaZjc9YuJRYyewJap/yeNeU5jZVGR02EySxj8JKqxWOBtowYPAXmY2sC3dTWF8y7zgsmi0Yju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7281
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Aug 2024 08:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16764

Hi all,

CIP kernel team has released Linux kernel v5.10.223-cip51.
The linux-5.10.y-cip tree has been updated base version from v5.10.221 to v=
5.10.223.
And this release includes patches for Renesas SoC and its reference board.

You can get this release via the git tree at:

  v5.10.223-cip51:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      53be161810164d318caa3cfe563e7054f161f1f4
    Fixed CVEs:
      CVE-2024-42157: s390/pkey: Wipe sensitive data on failure
      CVE-2024-41046: net: ethernet: lantiq_etop: fix double free in detach
      CVE-2024-42148: bnx2x: Fix multiple UBSAN array-index-out-of-bounds
      CVE-2024-42105: nilfs2: fix inode number range checks
      CVE-2024-42119: drm/amd/display: Skip finding free audio for unknown =
engine_id
      CVE-2024-41055: mm: prevent derefencing NULL ptr in pfn_section_valid=
()
      CVE-2024-42244: USB: serial: mos7840: fix crash on resume
      CVE-2024-42143: orangefs: fix out-of-bounds fsid access
      CVE-2024-36901: ipv6: prevent NULL dereference in ip6_output()
      CVE-2024-42137: Bluetooth: qca: Fix BT enable failure again for QCA63=
90 after warm reboot
      CVE-2024-39487: bonding: Fix out-of-bounds read in bond_option_arp_ip=
_targets_set()
      CVE-2024-42152: nvmet: fix a possible leak when destroy a ctrl during=
 qp establishment
      CVE-2024-41007: tcp: avoid too many retransmit packets
      CVE-2024-41040: net/sched: Fix UAF when resolving a clash
      CVE-2024-41034: nilfs2: fix kernel bug on rename operation of broken =
directory
      CVE-2024-42247: wireguard: allowedips: avoid unaligned 64-bit memory =
accesses
      CVE-2024-42232: libceph: fix race between delayed_work() and ceph_mon=
c_stop()
      CVE-2024-42120: drm/amd/display: Check pipe offset before setting vbl=
ank
      CVE-2024-42154: tcp_metrics: validate source addr length
      CVE-2024-42102: Revert "mm/writeback: fix possible divide-by-zero in =
wb_dirty_limits(), again"
      CVE-2024-42236: usb: gadget: configfs: Prevent OOB read/write in usb_=
string_copy()
      CVE-2024-42127: drm/lima: fix shared irq handling on driver remove
      CVE-2024-42121: drm/amd/display: Check index msg_id before read or wr=
ite
      CVE-2024-42115: jffs2: Fix potential illegal address access in jffs2_=
free_inode
      CVE-2024-41035: USB: core: Fix duplicate endpoint bug by clearing res=
erved bits in the descriptor
      CVE-2024-42153: i2c: pnx: Fix potential deadlock warning from del_tim=
er_sync() call in isr
      CVE-2024-41044: ppp: reject claimed-as-LCP but actually malformed pac=
kets
      CVE-2024-42106: inet_diag: Initialize pad field in struct inet_diag_r=
eq_v2
      CVE-2024-42223: media: dvb-frontends: tda10048: Fix integer overflow
      CVE-2024-42131: mm: avoid overflows in dirty throttling logic
      CVE-2024-42104: nilfs2: add missing check for inode numbers on direct=
ory entries
      CVE-2024-42145: IB/core: Implement a limit on UMAD receive List
      CVE-2024-42229: crypto: aead,cipher - zeroize key buffer after use
      CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
      CVE-2024-42161: bpf: Avoid uninitialized value in BPF_CORE_READ_BITFI=
ELD
      CVE-2024-42101: drm/nouveau: fix null pointer dereference in nouveau_=
connector_get_modes
      CVE-2024-42224: net: dsa: mv88e6xxx: Correct check for empty list
      CVE-2024-42124: scsi: qedf: Make qedf_execute_tmf() non-preemptible
      CVE-2024-40947: ima: Avoid blocking in RCU read-side critical section
      CVE-2024-41049: filelock: fix potential use-after-free in posix_lock_=
inode
      CVE-2024-41063: Bluetooth: hci_core: cancel all works upon hci_unregi=
ster_dev()
      CVE-2024-41065: powerpc/pseries: Whitelist dtl slub object for copyin=
g to userspace
      CVE-2024-36484: net: relax socket state check at accept time.
      CVE-2024-41059: hfsplus: fix uninit-value in copy_name
      CVE-2024-41015: ocfs2: add bounds checking to ocfs2_check_dir_entry()
      CVE-2024-41064: powerpc/eeh: avoid possible crash when edev->pdev cha=
nges
      CVE-2024-41072: wifi: cfg80211: wext: add extra SIOCSIWSCAN data chec=
k
      CVE-2024-41022: drm/amdgpu: Fix signedness bug in sdma_v4_0_process_t=
rap_irq()
      CVE-2024-41081: ila: block BH in ila_output()
      CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race=
 is detected
      CVE-2024-41078: btrfs: qgroup: fix quota root leak after quota disabl=
e failure
      CVE-2024-41068: s390/sclp: Fix sclp_init() cleanup on failure
      CVE-2024-41017: jfs: don't walk off the end of ealist
      CVE-2024-41070: KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_att=
ach_iommu_group()
      CVE-2024-36938: bpf, skmsg: Fix NULL pointer dereference in sk_psock_=
skb_ingress_enqueue
      CVE-2022-48666: scsi: core: Fix a use-after-free
      CVE-2024-41090: tap: add missing verification for short frame
      CVE-2024-41009: bpf: Fix overrunning reservations in ringbuf
      CVE-2024-41091: tun: add missing verification for short frame
      CVE-2024-41077: null_blk: fix validation of block size
      CVE-2024-41020: filelock: Fix fcntl/close race recovery compat path
    added commits:
      CIP: Bump version suffix to -cip51 after merge from stable
      net: ravb: Allow RX loop to move past DMA mapping errors
      net: ravb: Count packets instead of descriptors in R-Car RX path
      net: ravb: Always update error counters
      net: ravb: Always process TX descriptor ring
      ravb: Correct buffer size to map for R-Car Rx
      ravb: Unify Rx ring maintenance code paths
      ravb: Move maximum Rx descriptor data usage to info struct
      ravb: Use the max frame size from hardware info for RZ/G2L
      ravb: Create helper to allocate skb and align it
      ravb: Make it clear the information relates to maximum frame size
      ravb: Group descriptor types used in Rx ring
      rtc: isl1208: Update correct procedure for clearing alarm
      rtc: isl1208: Add a delay for clearing alarm
      dt-bindings: watchdog: dlg,da9062-watchdog: Drop blank space
      dmaengine: sh: rz-dmac: Fix lockdep assert warning
      arm64: dts: renesas: rz-smarc: Replace fixed regulator for USB VBUS
      phy: renesas: phy-rcar-gen3-usb2: Control VBUS for RZ/G2L SoCs
      regulator: Further restrict RZG2L USB VBCTRL regulator dependencies
      regulator: renesas-usb-vbus-regulator: Update the default
      regulator: Add Renesas RZ/G2L USB VBUS regulator driver
      reset: renesas: Add USB VBUS regulator device as child
      dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document USB VBUS regu=
lator
      regulator: core: Add helper for allow HW access to enable/disable reg=
ulator
      reset: rzg2l-usbphy-ctrl: Move reset controller registration
      arm64: defconfig: Enable Renesas DA9062 PMIC
      arm64: dts: renesas: rzg2ul-smarc: Enable PMIC and built-in RTC, GPIO=
 and ONKEY
      dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
      dt-bindings: mfd: dlg,da9063: Sort child devices
      dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
      dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
      dt-bindings: mfd: dlg,da9063: Update watchdog child node
      dt-bindings: mfd: da9062: Update watchdog description
      dt-bindings: watchdog: da9062-wdt: convert txt to yaml
      dt-bindings: mfd: Convert da9063 to yaml
      Input: da9063 - use dev_err_probe()
      Input: da9063 - drop redundant prints in probe()
      Input: da9063 - simplify obtaining OF match data
      Input: da9063 - add wakeup support
      pinctrl: da9062: Add OF table
      pinctrl: Propagate firmware node from a parent device
      rtc: da9063: Use dev_err_probe()
      rtc: da9063: Use device_get_match_data()
      rtc: da9063: Make IRQ as optional
      rtc: da9063: Mark the alarm IRQ as a wake IRQ
      rtc: da9063: add as wakeup source
      rtc: da9063: Simplify bool comparison
      mfd: da9062: Simplify obtaining I2C match data
      mfd: da9062: Remove IRQ requirement
      mfd: da9062: Use MFD_CELL_OF macro
      mfd: da9061: Fix Failed to set Two-Wire Bus Mode.
      mfd: da9062: Support SMBus and I2C mode
      mfd: da9062: Simplify getting of_device_id match data
      mfd: da9062: Drop of_match_ptr from of_device_id table
      mfd: da9xxx-core: Constify static struct resource
      mfd: core: Delete corresponding OF node entries from list on MFD remo=
val

Best regards,
   Nobuhiro




