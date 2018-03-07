module RequiredQueryAttributes
  describe Model do
    before(:all) do
      TestModel.create(column_1: 1, column_2: 2)
    end

    context 'with model not configured' do
      class ModelWithoutModule < TestModel
      end

      subject { ModelWithoutModule }

      it 'should not interfere with default behaviour' do
        expect(subject.count).to eq(1)
      end
    end

    context 'without required query attributes' do
      class ModelWithoutAttributes < TestModel
        include RequiredQueryAttributes::Model
      end

      subject { ModelWithoutAttributes }

      it 'should not interfere with default behaviour' do
        expect(subject.count).to eq(1)
      end
    end

    context 'with required query attributes' do
      class ModelWithAttributes < TestModel
        include RequiredQueryAttributes::Model
        require_query_attribute :column_1
      end

      subject { ModelWithAttributes }

      it 'should succeed with required attribute' do
        expect(subject.where(column_1: 1).count).to eq(1)
      end

      it 'should fail without required attribute' do
        expect { subject.where(column_2: 2).load }.to raise_error(RequiredAttributeMissing,
                                                                  /Required attributes \["column_1"\] missing from query/)
      end
    end
  end
end
