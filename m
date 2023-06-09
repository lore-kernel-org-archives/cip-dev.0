Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D725C7EE2E
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 11:10:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.10587.1686309024114485198
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jun 2023 04:10:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 359BA41W003286; Fri, 9 Jun 2023 20:10:04 +0900
X-Iguazu-Qid: 34trY2IxWIezG0vRfp
X-Iguazu-QSIG: v=2; s=0; t=1686309003; q=34trY2IxWIezG0vRfp; m=gb7uUOSu7ISATqxsHwPSk3YAI4+zfpjlK05xsyX0w8c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 359B9xeC036782
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 9 Jun 2023 20:10:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf0defjZ9bNZkXnWNuxOYooltLOCqC13E0mhd+4aiWfO+/p7ZMkqRWUvD57W+TfHPloOCDqrTd3yITO2ZrzlwEDhzNAg/4Fve6HyuIHEWm8oUoE+lTnZ7DorOIMBrIvRsgUkct6QfuuyT9MulpqgL8NrdF3dLfBCqA3frsk68UlHHipaQQr/b0IjboAzx6LohMAppU6fbGmOyTSs+v/E8hY1xvxKypgvn8lDL+H018dy35PrlhMIzfq+vHnBvJf7i7NuspM80e9yuAQfit/PdAweVmUPXKMwUOYqkXgp6Bjc3eCVoZmnODwO7sBPwlGtKcRYxYGZ+dQkAUx/TCd0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IvVligi6JrLCzKVdgc5ut9x/4JvVK6W4UfOxpWUlUg=;
 b=QEB/lfF4QSWvShBFrylyF4NjVk1lsjHmU/yl7cZm2D+PYIgkoXciWspuVXL2yr7DymQFjRXOGCY1ZQ9xzMOfqQO5Qz0XIAuY0iQLZKktrabFc7nLXyUNbi0sH8DEIAHCJSFUtL9WpauTTr4aDBeH73eZNtNDrmCCHup1wjVk0HUjtySFRB/4/qmrze+WG12m1QezWba9tK4rNI+RrOMbJzWt3eAknO143IqmJZEGXmYbeBLP31pmKXuSQ6EobThg7jX8K800fWXvhY8XBeNwqKi8etvI2VAAe6po1Y+S72Qf1Ym4plmYqMvbNkJF+l4ePeMeg+x+tnbRQ1yBA7W0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.284-cip99 and v5.10.182-cip35
Thread-Topic: [ANNOUNCE] Release v4.19.284-cip99 and v5.10.182-cip35
Thread-Index: Admawjjpoq8kh3RlTziKntg0BsYjXw==
Date: Fri, 9 Jun 2023 11:09:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94209B0236C145FE40C906C59251A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB11944:EE_
x-ms-office365-filtering-correlation-id: 1b3c2cfd-264f-4e69-e518-08db68da0fc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DL1T0dEdSwiiAXuVVmnQXJ5iak2RH5hjyr4UG0s3Qw2ach8M5aT919oGPJOSSK0FARAWbcVbHqYTw0HJOoNVebH1ke2I7HQTQMxfHggv3DaQIE4U1UbLYYqDIFkXw2TydRmu9FW7Q4hxcPaYckj7JwuzQlv2nu4+kLmTawiepGSkbxeS+eZMqth2QKI3bsuSuz14PTAoGlPcpOBNW5yplTUSwnj3zWQN354zTYJgjct8noEy1STn8z1YADyhrk4o7ow71JNCa6QZfD8pwdKvKPar4+10umrqUqb6t30/Q8aVYdBGY2KeEBpHqnXDckKBZKMuF39Eh8Jmq22ouTKmZTSco9r+OmgxupAlgA6C4/fqXTYSX6wPsR5LTwH+aEgg0Lw+bOJyGrJ5P63ey8ZLk8Xmvwxa6vJJUCdjXZCJc72pjEs0H3gh6CHFf8Z1/mgf//NlVLWFVZMccajlQNOuOIe8VJ9sl/qO3fjmvRaIFR5azM9oXUqVxQC/xg5qznpXcFYa19fNGXWMAhkAdpwY3PYqT19IYcu/V3lJiBlwhFJK8120vX0sf1jeJDbIGxyl85CfRFpzsqCVlKssD20botnO5FWPp0srtCseZxtoq1FpsTMRCAsz6GtPsVRDzu/v
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(52536014)(7696005)(55016003)(316002)(966005)(33656002)(54906003)(66946007)(122000001)(76116006)(66476007)(66446008)(66556008)(5660300002)(6916009)(2906002)(64756008)(4326008)(38070700005)(86362001)(41300700001)(38100700002)(8676002)(8936002)(71200400001)(478600001)(186003)(83380400001)(6506007)(9686003)(26005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?LzdrbzlPN1FxTFdtRmU4bUpPTWl4VUgzQmY0VmpZYzRCYVlsRE5UYWlH?=
 =?iso-2022-jp?B?dVdGRXJ4bE8zdmEvcjZCNHNYbE1pblRLWnpCYXNrR3NVSDROeDlCZC80?=
 =?iso-2022-jp?B?UjZxT0g2T09IUCtzOStvVUE2MGtIQ1JscGJTNXF6bFdkNXJzS0VUZ0s4?=
 =?iso-2022-jp?B?WjZ6WnVZbms1aGE5UGJQd3hnOEhaelpVTkowanhOTkFBRHJnUGhMUHB5?=
 =?iso-2022-jp?B?aE9hSTlqdS82cGUwOEJGc01pcWlMVnB6Ynk2QjREWnNZWklZT1dnNngw?=
 =?iso-2022-jp?B?dS9IeC9td0tWZTNZU2NVb1FMT1JoenBMZWRxazZtSWJrMVgya1F6SmxW?=
 =?iso-2022-jp?B?clJuN0JsU2dVVHlLS1RNSjJsdTE4VXZWOFlaSy9HcC9uMk1iZmtMQlRY?=
 =?iso-2022-jp?B?TGJXOThoOXpHdE1VZFJicGVGcVJMdG96YzB3djd1Y0pJemxxeEpNSXAv?=
 =?iso-2022-jp?B?Tndxd1ozS25yN1FTOG8wa1dYYkttWmV2a3lldkpVdlBlTG5mb0hSb090?=
 =?iso-2022-jp?B?STJManh1V3hBbkdjQUx5ajdMcjE5eTVXVDZudkVvUGdpc3dDTzBQc29N?=
 =?iso-2022-jp?B?MVA2MjREc2hGQ05OTkFkNC9NNGxhTmJLd0lCNU1HcmxBSVBRUkJiTjYz?=
 =?iso-2022-jp?B?Q0pYT05scVh4U0lUbmJXbENwT0VlQ2Uzb1lSZ1QxNk1CYlJKTVR3bjVp?=
 =?iso-2022-jp?B?aXlyQ09RUmNqZmFDTFBwWWxSN0tLVlRnM2F3ZEJUalJZc1lWNThUVzRU?=
 =?iso-2022-jp?B?VkYzOVRJZ2RsaUY0QUNtckt5eXVXeGQwMmVuZFlMT2tyTFcyUE04MHli?=
 =?iso-2022-jp?B?eG1Ec1VCOHRhcTFKYlovWEs1VXdFaXl1VGZ2TzFDTW5GLzJmbHdxRGl4?=
 =?iso-2022-jp?B?aG1zbUVnbFVBZTBoNnBpdm5Sa3hueURIZ2xaQ3IwL2JiQ0hNMmRLdlVt?=
 =?iso-2022-jp?B?b3k1cVdEMzI2QXFQTmxpb1BIeHJmWExZRTRMOEwyK3JUSlprSllWZDBm?=
 =?iso-2022-jp?B?b3E3clg5ZVJlVGlaSHZTcGl6Ymk2bEw2WlF6dUdXYXFYcWlvMnpmL1kr?=
 =?iso-2022-jp?B?T2NoTm5HdUVxd0ZCQm9HQS9NUFg5dlRzL0NDV3lzdTZST0ZieGJ0ZEdM?=
 =?iso-2022-jp?B?eVhPSUxDaHRPb3hkYkVQRU5uanlhNWVqNkZpNTBwczhzbmt5WnFDRVV3?=
 =?iso-2022-jp?B?cko2eFlEZVN3K2tvNDZCbzJpTXQ5MFcyTldBbFZVSjBEZlBlUnhGYjMw?=
 =?iso-2022-jp?B?ZzliZVFsMDdDdHB3NGZOekY5TitVaVAxZXFERzJLVWpNUnRkME00dWN0?=
 =?iso-2022-jp?B?aGg3REt5TVJMREpIekZONEpnanRwM1Qwc1o4M2tBOVR5WE12ck93aGJC?=
 =?iso-2022-jp?B?MEVvNWEyTUpqWk9SZGZNYUp2NmVycEtZVFBIL2g3b1hIbmFCTUVnVzRz?=
 =?iso-2022-jp?B?blhOMzFhbDV0NnNQMmFFN3pNazdRU0xvQTdvdkdtOWVJSGExOUNoV2dW?=
 =?iso-2022-jp?B?S1VOT0E3Z3hzaUNqYXlPckhrakFiRG9ROERHbXhtVENvY3hNTGd5Zysr?=
 =?iso-2022-jp?B?RC9QTU8zVzd3YnhxajNwY1QxVGdVQmdBdS90OThrUUhXOFY5K2JyVmN5?=
 =?iso-2022-jp?B?QUs0ZGJKaUp1ZGVlWW02bFg5MGcvMDZ5Y2xQaFBwcVRseFFQTTRRRzI2?=
 =?iso-2022-jp?B?cHdwNmJ2NkdHVmJWZ1VzWjRlRmpjZU05bFdDMWNpeXlSZWNoOHJjS0du?=
 =?iso-2022-jp?B?cHhSSHpvN1Z3WTdCcTQzSjRFbHIxSXpLTGZnTG1XRVQvU09lMjNmMFQw?=
 =?iso-2022-jp?B?Zitnck1oN1VMVTdGYUZtQUo5S3grcURSektFVWsyY1hqNGdYUFdrbFdK?=
 =?iso-2022-jp?B?dDNEUlFnM0tERlV6ZWNyRHh2cm9KNy9qZ3JXcURyejl6MzU0MFBibC9s?=
 =?iso-2022-jp?B?UTMxWW5FTmhCSGNJVVRDcVgvN0V6VGNkT3FzK01MRE5XSGRJQlRPcWhv?=
 =?iso-2022-jp?B?U1gzRDNicXg3ZkY0QmRMVm0rN2YvV0tjSWJENWlVdStGZVIxaERuQWR1?=
 =?iso-2022-jp?B?N1dndmdyZ2hoSHdKYmVpVTNLd3R3Z2M2dWVYam84N2tBNTJIMVF5V0Nw?=
 =?iso-2022-jp?B?cnduWWRzeGpsWUw1N3liT2dwTjZoRjdsSDg0U3lRZmd3ZmlLQlhSeVZo?=
 =?iso-2022-jp?B?c0ZzN1NpMEZ6UzA2RWpyZzROUjJPeklDUmFJUmRIeFk0dWliVnlCdktW?=
 =?iso-2022-jp?B?NndyUUJDYXF3UEpCQ1FhcmpEN1BXcjdONmpvVHJjR0tMM0FYZmtTbVM4?=
 =?iso-2022-jp?B?ZlBjeUowMDB6WCtqWjljQ3NWWUlYNjlENHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?b1NpS0JFOTV1M2toREc0VTJzcm5NbFRhQk5idVpNSG9ra3RCcDdVSEVn?=
 =?iso-2022-jp?B?bEV4cW1KRGFmNjdNdWhLYlNLNk9qSnk3K1ROekdCaTBsZk5hejNuV1lG?=
 =?iso-2022-jp?B?S1dDTlR3Tk0zTys3VXk2aEN3T2ZwMCtJR2lMNFRmOTlVc1NqenZMc2Fl?=
 =?iso-2022-jp?B?cmFNcjY5SWhubzlzams4amNXc3VySXhxV1c4UDB5TGNOeE9wYmVrM0xO?=
 =?iso-2022-jp?B?WjIxTW9IdjFlcElBTlJxTkpJaFU1bW9CeC8xOUNURCtEUmNmMmo0R0pE?=
 =?iso-2022-jp?B?UVoxdWhCOU1RYzNGL1R6SEFGeERqMnVKZElRZXdpVG44NGxRc0JIOHda?=
 =?iso-2022-jp?B?RUQ0b25TSkdydlpVL2ZPV0lRc2hUUEMvWFN0ZTdKeVVma2gyQVRTT25x?=
 =?iso-2022-jp?B?NWwwYkFVTDBlblNXTE10Kzkyc2RGd2dYeEU5NlBTV3AwUHREb1o0Q2VS?=
 =?iso-2022-jp?B?OW9oYjRoSlJldlU0SkRiQ3V0ZmRaV0hsVmJNQnJYa0pKUHlOSHRhUCtQ?=
 =?iso-2022-jp?B?S1I1aGFlWVI0eWJpTXFJSi9lazJhdTVEQTErNno1OHdPVlAxUjZlRmFV?=
 =?iso-2022-jp?B?TWJDTUZ3bmxqRjVaN3Y1WEFiWnRDV2orZVNpOWFtQ090OGI0Mnc1UDNi?=
 =?iso-2022-jp?B?Y3pLeXZpck13RWdNZTg4QjhLTlVpNjFaUE9ZdkN1WGl0Q0lWUmJDZTBW?=
 =?iso-2022-jp?B?ejVsZ3NrWlJ4K05tQTBuaVNvbDZvRmJSekREalp4VVF1OVVKR1FVVzZr?=
 =?iso-2022-jp?B?K0FGNDFzZjBlNlh0MFhyNS9tcHVZTkZVWEE3aHVPM004OEEyZDBYWHUy?=
 =?iso-2022-jp?B?MWNmYlBuVjZ2MTdDVjZ2enNaTkhaSE5ZNEpTN1REc2RaaUEzTGhuZTdI?=
 =?iso-2022-jp?B?emhIZ2JjK1pmNEhoWXVnMDF4eFkxWnlBMXNxWkxxUHdTVTdFdk9nb3lT?=
 =?iso-2022-jp?B?OCt6YUlCQXQxbTNQcWo3S0c1bmVEenZJUlZva292a0Y0NUp4STJZVkhh?=
 =?iso-2022-jp?B?b0lIemNoeGNHbnRPNmlqSTRmcXkrTy9aajNFeWZ5OE9hVGMrVk1PSk5z?=
 =?iso-2022-jp?B?SVhSSTBmSDYrakM1ZmlNUEhxRlI5S1VNUUJ4SStNUzlBNGd6WDVhK0pa?=
 =?iso-2022-jp?B?cnBoam9xWngzQjRNSy9jUzBGQVlpRkd2QURIaktoZVprVVhqSm4rVXlo?=
 =?iso-2022-jp?B?TmcvYlYzUU5nRG5sTCs1aTlIeC9yMmRjSjF5YitOUkhIWW96MnZwR09F?=
 =?iso-2022-jp?B?aXg2N2luUEdJS01VL2JXNkE1NVI4Sm5OU0tDY1dYWHdlKzNNdHhaR2Fx?=
 =?iso-2022-jp?B?UGZMOFVHN1FjZ05VYm03cldvUVY5TmdoSVZtM0VkSUFUb3Y1SnEwUmxR?=
 =?iso-2022-jp?B?aURvU1BEbC9KRFZoZFBmdz09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3c2cfd-264f-4e69-e518-08db68da0fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 11:09:57.9377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQM6RXuvSpa9x6NeulR93L9d5QpH2Vf8M+TU0hLH4+b/AnS8QG43hzYoxAH6xwM4OeNtURSLaESHBj/93jCwpeCxDA0SIYh54XStE5haTWqPpbe+ZakZ4BAIDOtQcTIt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11944
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 11:10:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11933

Hi all,

CIP kernel team has released Linux kernel v4.19.284-cip99 and v5.10.182-cip=
35.
The linux-4.19.y-cip tree has been updated base version from v4.19.283 to v=
4.19.284, and the linux-5.10.y-cip tree has been updated base version from
v5.10.180 to v5.10.182.
The linux-5.10.y-cip tree includes USB and serial port patches for Renesas =
ARM64 SoCs.

You can get this release via the git tree at:

  v4.19.284-cip99:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      a13de4c6b84ab64a5cb3ef5e852b1620686d0309
    Fixed CVEs:
      CVE-2022-34918: netfilter: nf_tables: stricter validation of element =
data
    added commits:
      CIP: Bump version suffix to -cip99 after merge from stable

  v5.10.182-cip35:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      52f00829380df13d144d530b732464a175350508
    Fixed CVEs:
      CVE-2022-4269: kernel: net: CPU soft lockup in TC mirred egress-to-in=
gress action
    added commits:
      CIP: Bump version suffix to -cip35 after merge from stable
      arm64: dts: renesas: rzg2ul-smarc: Enable SCI0
      tty: serial: sh-sci: Add RZ/G2L SCIFA DMA rx support
      tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support
      tty: serial: sh-sci: Remove setting {src,dst}_{addr,addr_width} based=
 on DMA direction
      tty: serial: sh-sci: Fix end of transmission on SCI
      tty: serial: sh-sci: Add support for tx end interrupt handling
      tty: serial: sh-sci: Fix TE setting on SCI IP
      arm64: defconfig: Enable RZ/V2M xHCI and USB3.1 DRD controller suppor=
t
      arm64: dts: renesas: rzv2mevk2: Enable USB3 role switch
      arm64: dts: renesas: rzv2mevk2: Enable USB3 DRD, Peripheral and Host
      arm64: dts: renesas: r9a09g011: Add USB3 DRD, device and host nodes
      xhci: split out rcar/rz support from xhci-plat.c
      usb: host: xhci-plat: Remove useless DMA-32 fallback configuration
      xhci: host: Add Renesas RZ/V2M SoC support
      usb: host: xhci-plat: Add reset support
      usb: host: xhci-plat: Improve clock handling in probe()
      usb: gadget: udc: renesas_usb3: Add role switch support for RZ/V2M
      usb: gadget: Add support for RZ/V2M USB3DRD driver
      dt-bindings: usb: Add RZ/V2M USB3DRD binding
      dt-bindings: usb: renesas,usb3-peri: Document RZ/V2MA bindings
      usb: gadget: udc: renesas_usb3: Add support for RZ/V2M
      dt-bindings: usb: renesas,usb3-peri: Update reset, clock-name and int=
errupts properties
      dt-bindings: usb: renesas, usb3-peri: Document RZ/V2M r9a09g011 suppo=
rt
      dt-bindings: usb: renesas,usb-xhci: Document RZ/V2M support
      usb: typec: hd3ss3220: Add polling support
      clk: renesas: r9a09g011: Add USB clock and reset entries

Best regards,
   Nobuhiro


