use core::array::{ArrayTrait, SpanTrait};
use orion::operators::tensor::{TensorTrait, Tensor};
use orion::operators::tensor::{FP16x16Tensor, FP16x16TensorAdd};
use orion::numbers::{FixedTrait, FP16x16};

fn output_0() -> Tensor<FP16x16> {
    let mut shape = ArrayTrait::<usize>::new();
    shape.append(1);
    shape.append(1);
    shape.append(2);
    shape.append(2);

    let mut data = ArrayTrait::new();
    data.append(FP16x16 { mag: 688128, sign: false });
    data.append(FP16x16 { mag: 845414, sign: false });
    data.append(FP16x16 { mag: 1376256, sign: false });
    data.append(FP16x16 { mag: 1271398, sign: false });
    TensorTrait::new(shape.span(), data.span())
}
