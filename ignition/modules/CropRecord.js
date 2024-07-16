const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");



module.exports = buildModule("CropRecord", (m) => {


  const CropRecord = m.contract("CropRecord", []);

  return { CropRecord };
});
