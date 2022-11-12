Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC1FC4332F
	for <webhook@archiver.kernel.org>; Sat, 12 Nov 2022 23:43:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.41.1668296631521083760
 for <cip-dev@lists.cip-project.org>;
 Sat, 12 Nov 2022 15:43:52 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 2ACNhS29010352; Sun, 13 Nov 2022 08:43:29 +0900
X-Iguazu-Qid: 2wHHullzhxm35pQomO
X-Iguazu-QSIG: v=2; s=0; t=1668296608; q=2wHHullzhxm35pQomO; m=9o8RKInYln4MclXx8XCSj67ySIQ3u2+XDXqQ1hl2gsM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 2ACNhPfJ003888
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 13 Nov 2022 08:43:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIdRopBEousZeV7suUCLD7ZLmDg7GSKxolBfKQhLoTyyjCGkKrxn4EvhSC3cyVv1ZQG5GKBclFCLXqkI22OMYFQCwqmGOj0B6Ev7d34+qQ3B7q39HbhUZrb7mRIUiQvm526ilN7ITuTgpwqMPpXO6YZEHEy5QrRQjvfz4bY/y5XwS+EQdqRPNX2s4XV6Ocnbq9xKcLcIGi9Q7d3u/uHXmEc5/P1u+nJiuvhOGRf/SUcRKXmvGJOZLrsTEX7LVYlZvPuUZvkBNGgoEDxM+pxartJJLbcdI5ifB0mzcdt+vssC4F0X41aU6BPYCdS/JCmNN1AkukbJocvQUAMu8cnB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIKSeYtcj6woNQeAUZjRlUeIkc/UZrl5plwnDpcwRl0=;
 b=lUz6PTe7OSX7E5VSfGlpiT5mO7aF3zUFYaknTROSYD6D3MY3GO/hqS/GD25D/O+n1mUTIE0n0aK91C1YLTV9QW9ck8o7xv0PGSlmBFumDnZGRVvb1OhNEC0aWWPt8THmHNqlUSkGgM98A5ZCYN/Klh5h9AIzRNzxv18GJjBpPYzTw6Tbpdz+f/Ups00jMUD7xXzNdPArh2Ni7K9CI4M3w07FjtkuEPZJ02jMDGNl8T7FbJvpFRk/euUkUh3XS7fqwsdGPKBMkyxMj3dUqgGWrOYRpccWB6c/QuHV/RnBH5Ek0eziDRvKk6Oet7unptpA8mv1D68L1BqPBdqt33GU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v4.19.265-cip85 and v5.10.154-cip20
Thread-Topic: [ANNOUNCE] Release v4.19.265-cip85 and v5.10.154-cip20
Thread-Index: Adj28CGFYwgvC1K7QuKYEE+t5lPaiQ==
Date: Sat, 12 Nov 2022 23:43:23 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420E3A8B4806B0E697B78BC92039@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYVPR01MB10734:EE_
x-ms-office365-filtering-correlation-id: 8bf0a425-e823-42d1-446b-08dac507afde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUkk2yUWvXiMUHc5eXAbvMXy0Y0TSiQhViehiq55Ub8DD7MD/v+XtTwRgmbuS8FIDMexp2i+5lGNRUnmDxvbhgo0+zvFr8j0vfQl7x9mU9cuSMeuph9/rk2vnE22fTTo+I64OqpzsnSRGg+Dn+SPXt3FdZ5S671zgGOqRJbJ9h2VYyb+6wBGUE2abQ5hzYtc8M0ivLNnPThEd10MFLtfSGpibBZh90E30yZIR8gGGM5ZrblINCcgFS+RfF7GIAZ5FLcahx3weYwlXjACbJ7J/nPKmanJVf2iIVKYy8dI+PeLPKp9eciwz7116t16mxyVVYwnadmSeSFLz/ugCphUc/Eb4g5QiHNj2+/TBWjl+o8Tge26l5JxRxoVKJ1XLxq/93ZmloV0RO15yIxOJyttHNoEAFjD4d39aGenYJ1dRmgJm9Zzwg8dnwsNFoQ+Oy6VLdeuBWpRry4Cl8hHqHp4ktIhCc53Yiq9chnqMgKlRS2GCJlD9VyPXor8bah3srO+ikpvGulF5uhMh5CwwP8eM0K4MhOzL1SH3pknILPCMftsYNTKczN6AfxrEyPzPdklz5393xR4jvq2UhPSqyxim7cFX8ECqg/Ly282kyK7Jvf0MlRjHh6Ksw1LnbhsrAKHf31iQCoXXB0zVFgLnpRL2H/WPu8KGMwSRy54YT5YbIgU9OuctlnTSQ/OD27GA+1eHbbMlyiQ4QCEduQ0KDrH8tfSkfBBOmMjvCMczEMk2S+ox2Lt0cUXaZTYeAFhsxHJICJT/pZ4vVGwyTC8ME8qMmq5d4caE/0E63ALSg8xcKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(5660300002)(52536014)(8936002)(186003)(9686003)(26005)(33656002)(55016003)(86362001)(6506007)(7696005)(71200400001)(966005)(478600001)(83380400001)(2906002)(38070700005)(64756008)(66446008)(66476007)(4326008)(8676002)(66946007)(76116006)(66556008)(316002)(122000001)(41300700001)(6916009)(54906003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eTRRcGRHMnZDcElib2M1S1hXNTBzL3FvZm5DNldqR09ybU1kYkxWVDRp?=
 =?iso-2022-jp?B?OGlXVGtjcWFxQVFQUXZNQ3VtKzhBU2hkeVMxU1plTXZxcHZvbzRzTDNq?=
 =?iso-2022-jp?B?RzU1T1MvcHpWL25XRVRNS1RnYkFrS1VNMmEyd0FmOWM4MWhYNHFBR2F5?=
 =?iso-2022-jp?B?MWx5d1Z6K25DbysrUHZRaGVuZlNnWVM2QWxWSUVZcUhxWHBkb3IyVS9W?=
 =?iso-2022-jp?B?c3M4Rlh0UXF4OGZ2b2tJanY5TmJXUGdrRGxIdkxVaE9neUpyL0wrSVdv?=
 =?iso-2022-jp?B?WW9DbEFwS28yejhCZFR5bkRTbm1oV1lrTWhxQU5UTHB0US9WUUEyblAx?=
 =?iso-2022-jp?B?aUJabzlBSlNvbytEUWZraFovUG8xaU9mS3duQTY4dWd1Wnh1TmVmSkZB?=
 =?iso-2022-jp?B?QTBhcE1nNVVGL3dOaGZQZUVVdkJPQlRNY2E0NWxyRGhYUFF1dmtyK1ZV?=
 =?iso-2022-jp?B?S1hZQk1JaUE1ME9IaFJSR3NDMlBxeWdzTUNFVUNLdXdqZk5WYzlNZkNu?=
 =?iso-2022-jp?B?eC90cURHM1pYeGRlL0loMmRJdTdIOGdwaFNJNk1SYzRpOXNqaFJwdC9k?=
 =?iso-2022-jp?B?eDJBK1h2eWgxeEsvR2hwN2JtNVpjOGkrc2pZSHE0VHhtRDIzTEE1cXo2?=
 =?iso-2022-jp?B?VHJrdW9ybzdEd0gvajZPRFV3UHRLRWQ1NzVXbS9LTmsrdlRqeVYzNldD?=
 =?iso-2022-jp?B?N1pYRFE3RXB1RitiblFCTEwwbGtlM3hURjcvRWN4UjBIVHdJRkVON0N5?=
 =?iso-2022-jp?B?cWRkVS9OeHRBcEcvdEh2MldCTWVvTmcySEt1RU05WmFzTllsSGFUMlJm?=
 =?iso-2022-jp?B?YnNGRXNZU0lrSmZlV2tsZkxDT2FmQ0lVTFYzZUpZdHZCbVdCTWE3TFU1?=
 =?iso-2022-jp?B?TnpkaWsrbENqMm42TmVGSkhNbThmcFU1ZXd3ZDEvb2Z2NnV1M3JtMEMr?=
 =?iso-2022-jp?B?UFFGUjRQUkR4OGZlTzFmd1F1c3oxeFhLMUpOa0xXUFI4MXcvbDJMcEtZ?=
 =?iso-2022-jp?B?WXlzcE9jdFlhS3JKa1lZT1NmRXpzQ2JxZjRxd3M4U2k0eHdtSnJyL0s0?=
 =?iso-2022-jp?B?QXJxZXdPdElmVXJLSDNYTW5wM3VQWGpoMkJiVzF5OFVWUmtEN1Bvekhn?=
 =?iso-2022-jp?B?Wmgwak1QVytQSlQ2dVN1dEZHNk5ONGVVb2pMbWRZWVpvWFJ4NXVySWJr?=
 =?iso-2022-jp?B?Mjl4UnN4T2sxVG1ReVkvbmtzcWk0WHZlOGtCRzVjbWRQRDR2cHhEalhC?=
 =?iso-2022-jp?B?ajZuM0V1dE12WkxZUjgrdzV3S3Q3NzVmMmlaQkdaZXBvQlJWSGd2MDdq?=
 =?iso-2022-jp?B?SStvcldiZy9QLzQ4R3F0akEzaGc2NjZXQ1ZDWXcwQWZLYWZKakI2UGU5?=
 =?iso-2022-jp?B?MllYSkJMbzltdCtoMVFGTnNEK3Q1Sm8yNGh2Z2p3bjhhSVJBVGJYZnp1?=
 =?iso-2022-jp?B?ZjRWRlp3TE93TGYwZ1BzdkhleFZyZ2xXUWQ3OU9PUGF6RmpzZWErMVVN?=
 =?iso-2022-jp?B?eThuSW04VVBGMFlSVDZDNlljS29ZZWJvRm4yYklCQmpXVElXRm9Hc256?=
 =?iso-2022-jp?B?VFFIMVBSMEU3TVJJQWN5WUtiSHozMTBDZjJJUy9tb2JEdTdYeEdZc0M1?=
 =?iso-2022-jp?B?UXJmY1o4UU12dzQ4bTVkNGFMaDdXeTVPdENsSjBnOUNRZ1B2OEVaa0JR?=
 =?iso-2022-jp?B?ZkVQTlk1b0lUQlg1MGtpTjRld2drWnFaYzEzZm5GOUtKRGZJc3BDRGpK?=
 =?iso-2022-jp?B?QjBYZUpBVzNJYktXdVlQeDdwZEdLU3Q1K0xKSGwwUUZUeEtFeVlVQnFF?=
 =?iso-2022-jp?B?cE8xZnZuZksrL3VuWlF3M09wWkJvL1FIZ0NKb2xXMFIwcnlmUmQvOVIy?=
 =?iso-2022-jp?B?K0MzOUFzRXl6cUFpcSthQlNHc3JKT1BZUzFyZEJ4UjJ3MWluN3dlb2Fr?=
 =?iso-2022-jp?B?NlRodS93M2s1b2RGd3RnVmNiRjdnOU01VGFQdUZuSHVxanU5U3pJUW45?=
 =?iso-2022-jp?B?YWx4L0M4Sm82R04xU1pOOEtTSTg1TXVxS25Vbjl3ZjdTdEZCVjZXTWNV?=
 =?iso-2022-jp?B?eGRnZGlxaHNiTm9uMlY3cHAzYmdJVFBML3lrUWhaMFE3cnlJWU9xckVy?=
 =?iso-2022-jp?B?Q3JuOThxM1hBR05sdnJvMDdXcGpaQjFZam4xV25HQUpFTjcyUXBrSTkv?=
 =?iso-2022-jp?B?SWVQQ3ZPVFhkYUo3S2hzTzV3cnBpYUlXNXB0N1lLYkdPNzNQSm9URDVJ?=
 =?iso-2022-jp?B?MmNUL1lhNkRZemhqMDU5YmtLaWZ6NmMvNmNQenoxOW85NXkrbm1Xbzhn?=
 =?iso-2022-jp?B?ZjErTjlMblFzNzZlR0tpVGlBVGZOMWJvaWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf0a425-e823-42d1-446b-08dac507afde
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 23:43:23.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RSmaQgTgt7T1Sg9ZP+epL64VCQbcsketVzinOlBiUEFvq5jxgKgCBYphgxwA3BBvCBGvr+1/cXrWgeGHf7z+lT131hgZEUiet0pp/qnMmqnV5lPkgrFku8TWBJqoS0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10734
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 12 Nov 2022 23:43:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10024

Hi all,

CIP kernel team has released Linux kernel v4.19.265-cip85 and v5.10.154-cip=
20.
The linux-4.19.y-cip tree has been updated base version from v4.19.264 to v=
4.19.265,
and the linux-5.10.y-cip tree has been updated base version from v5.10.153 =
to v5.10.154.
In linux-5.10.y-cip, MMC driver for Renesas ARM SoC was updated.

You can get this release via the git tree at:

  v4.19.265-cip85:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      f79656a3459e88f17f36f060c6e711b0556bb755
    Fixed CVEs:
      CVE-2022-3628: wifi: brcmfmac: Fix potential buffer overflow in brcmf=
_fweh_event_worker()
      CVE-2022-42895: Bluetooth: L2CAP: Fix attempting to access uninitiali=
zed memory
    added commits:
      CIP: Bump version suffix to -cip85 after merge from stable

  v5.10.154-cip20:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      efa0ded8f5c8a9e3835e4aea63caa6cffb0ccda8
    Fixed CVEs:
      CVE-2022-3628: wifi: brcmfmac: Fix potential buffer overflow in brcmf=
_fweh_event_worker()
      CVE-2022-42895: Bluetooth: L2CAP: Fix attempting to access uninitiali=
zed memory
      CVE-2022-42896: Bluetooth: L2CAP: Fix accepting connection request fo=
r invalid SPSM
    added commits:
      CIP: Bump version suffix to -cip20 after merge from stable
      clk: renesas: rzg2l: Support sd clk mux round operation
      mmc: renesas_sdhi: Fix rounding errors
      mmc: tmio: avoid glitches when resetting

Best regards,
   Nobuhiro


