From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 31 Jan 2019 08:45:52 +0000
Subject: [cip-dev] [CIP SW Updates] architecture draft
Message-ID: <OSAPR01MB37637F39F9FD791CB243776CD0910@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear CIPers,

After completing the survey, I have been investigating and reviewing a lot of update tools. As a result, I have extracted the most important requirements and I have designed an abstract architecture of what I would like to achieve. You can find the architecture attached and an example implementation using casync and RAUC to this e-mail.

This is still very blurry, but I hope that in the next milestone (tools comparison) I make it more clear.

Currently, after trying some binary delta generation tools, I am geared towards using a "casync" approach. I didn't know about casync but when I found it, I thought it was very neat. The key points of using casync are:
- operating system images can share common chunks of data: minimiza storage required on the server
- when using file trees, it concatenates them and create chunks of sizes that are friendly to the network. 
- it is much easier to manage than using binary deltas

So basically, the server will by casync plus sugar (https server, PKI infrastructure..).

For the client, I have two possible ideas:
- One is to just use RAUC, which seems to have support for casync already (although it says experimental)
- The other one would be to have a very very simple daemon on the client, so that it is easy to add on any image generation tool. This daemon would only need to download the update metadata (casync index, an updater script), verify the signature, and execute the updater script.

If you have any feedback, please let me know.

Thanks,
Daniel



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: cip-swupdates-arch.txt
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190131/3d69c089/attachment.txt>
