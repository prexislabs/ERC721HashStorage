const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ERC721HashStorage", function () {
  it("mints and burns", async function () {
    const MyToken = await ethers.getContractFactory("MyToken");
    const mytoken = await MyToken.deploy();
    await mytoken.deployed();

    const metadataHash =
      "0x6aaf8f326d9d27d212e8647cbd1306dc1687f90595d0e6821e274d4d6312c387";
    const mediaHash =
      "0x3ce0d71b7d44ca4c43b07ea744eeaa9c1281b6d50ed90ed13a0b785cc10a289b";

    await mytoken.safeMint("metadata.json", metadataHash, mediaHash);

    expect(await mytoken.tokenMetadataHash(0)).to.equal(metadataHash);
    expect(await mytoken.tokenMediaHash(0)).to.equal(mediaHash);

    await mytoken.burn(0);

    // eslint-disable-next-line prettier/prettier
    expect(await mytoken.tokenMetadataHash(0)).to.equal(ethers.constants.HashZero);
    expect(await mytoken.tokenMediaHash(0)).to.equal(ethers.constants.HashZero);
  });
});
